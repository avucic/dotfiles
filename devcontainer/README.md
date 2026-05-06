# Dev Containers

Personal development container setup. One reusable base image carries the
editor/shell tooling (nvim, zsh, lazygit, eza, ...). Each project layers its
language toolchain on top, then `devcontainer up` mounts dotfiles, ssh keys,
and named caches at runtime.

## Layout

```
~/.dotfiles/
├── devcontainer/
│   ├── Dockerfile        # base image — installs editor/shell tools
│   ├── compose.yml       # shared mounts/env, included by every project
│   ├── install-image.sh  # personal install script (stow, etc.)
│   └── README.md         # this file
└── bin/bin/
    ├── dev-build         # build a dev image
    ├── dev-install       # scaffold .devcontainer/ in a project
    ├── dev-up            # start a project's devcontainer
    ├── dev-exec          # exec into a running devcontainer
    └── dev-down          # stop a project's devcontainer
```

## Prereqs

- Docker (with BuildKit, default in modern Docker)
- `devcontainer` CLI (`brew install devcontainer`)
- jq (only for legacy users; the new flow doesn't use it)
- This dotfiles repo stow-installed at `~/.dotfiles/`
- `~/.dotfiles/bin/` on `PATH`

## CLI commands

| Command       | Purpose                                                                                      |
| ------------- | -------------------------------------------------------------------------------------------- |
| `dev-build`   | Build a dev image. Layers the toolbox Dockerfile on top of any base.                         |
| `dev-install` | Scaffold `.devcontainer/{devcontainer.json,compose.yml}` in `$PWD`.                          |
| `dev-up`      | Start the devcontainer for the project rooted at `$PWD` (walks up to find `.devcontainer/`). |
| `dev-exec`    | Exec into the running devcontainer for `$PWD`.                                               |
| `dev-down`    | Stop the devcontainer for `$PWD`. `-v` also removes project-local volumes; `--rmi` the image. |

## Quick start

### 1. Build the base image

```sh
dev-build --from debian:trixie-slim --tag dotfiles-box
```

Produces `dotfiles-box` with editor/shell tools, your dotfiles, and
`install-image.sh` applied. Run once. Re-run when the toolbox Dockerfile
changes.

### 2. Scaffold a project

```sh
cd path/to/project
dev-install
```

Creates `.devcontainer/devcontainer.json` and `.devcontainer/compose.yml`.
The compose file points `image:` at `<project-name>-dev` (a placeholder).

### 3. Build the project's dev image

`dev-build` requires `--from` (base image) and `--tag` (output name):

```sh
# layer toolbox on top of a project base image
dev-build --from tabz-api  --tag tabz-api-dev

# layer toolbox on top of an upstream language image
dev-build --from rust:1.93-slim-bookworm --tag rust-1.93-dev
dev-build --from node:20                 --tag node-20-dev
```

The base must be Debian/Ubuntu (apt-based). Alpine bases will need a different
toolbox Dockerfile.

### 4. Start the devcontainer

```sh
cd path/to/project
dev-up                  # spins up the container
dev-exec zsh            # shell into it
dev-down                # stop when done (preserves volumes)
dev-down -v             # also remove project-local volumes
```

`dev-up` walks up from `$PWD` to find `.devcontainer/`, sets the workspace to
the directory containing it, and runs `devcontainer up`. `dev-down` stops
the same compose project; the globally-shared `tabz-*` volumes are never
touched (they belong to no single project).

## Per-project files

`dev-install` produces:

**`.devcontainer/devcontainer.json`**

```jsonc
{
  "name": "myproject",
  "dockerComposeFile": "compose.yml",
  "service": "dev",
  "workspaceFolder": "/app",
}
```

**`.devcontainer/compose.yml`**

```yaml
include:
  - ${HOME}/.dotfiles/devcontainer/compose.yml

services:
  dev:
    image: myproject-dev
    volumes:
      - ..:/app
      # add language-specific cache mounts here
    working_dir: /app

# add named volumes used above
```

The `include:` directive merges the base compose into this file: editor
volumes (nvim/zoxide/znap), dotfile mounts, ssh, env vars, and the keep-alive
command all come from there. The project file only adds what's project-specific
(image, source mount, language caches).

## Volume sharing

Globally-shared volumes are declared `external: true`. They live outside any
compose project's lifecycle, so `dev-down -v` can never delete them, and
multiple projects can attach the same volume without compose grumbling about
ownership labels. `dev-up` ensures the universal ones exist before starting
(idempotent `docker volume create`).

Project compose attaches what it needs and re-declares the same `external`
entries:

```yaml
services:
  dev:
    volumes:
      - tabz-cargo:/root/.cargo
      - tabz-rustup:/root/.rustup

volumes:
  tabz-cargo:  { external: true }
  tabz-rustup: { external: true }
```

If you add a new shared language cache (`tabz-pip`, etc.), add it to the loop
in `dev-up` so it auto-creates on next start.

## Common scenarios

### Rust project

```sh
cd path/to/svc
dev-install
dev-build --from rust:1.93-slim-bookworm --tag rust-1.93-dev
```

Edit `compose.yml`:

```yaml
services:
  dev:
    image: rust-1.93-dev
    volumes:
      - ..:/app
      - tabz-cargo:/root/.cargo
      - tabz-rustup:/root/.rustup
      - svc-target:/app/target
    working_dir: /app

volumes:
  svc-target:
  tabz-cargo:  { external: true }
  tabz-rustup: { external: true }
```

### Node project on top of a project image

```sh
cd path/to/api
dev-install
dev-build --from tabz-api --tag api-dev
```

Edit `compose.yml`:

```yaml
services:
  dev:
    image: api-dev
    volumes:
      - ..:/app
      - tabz-pnpm:/root/.local/share/pnpm
    working_dir: /app

volumes:
  tabz-pnpm: { external: true }
```

### Project with nothing language-specific

Skip `dev-build` entirely. In `compose.yml`:

```yaml
services:
  dev:
    image: dotfiles-box
    volumes:
      - ..:/app
    working_dir: /app
```

### Project with existing base image

Skip `dev-build` entirely. In `compose.yml`:

```yaml
services:
  dev:
    image: base-image-dev
    volumes:
      - ..:/app
    working_dir: /app
```

## Gotchas

- **Path resolution between compose files**: `include:` resolves each file's
  paths relative to that file's own directory. Don't go back to
  `dockerComposeFile` arrays — that mode resolves all paths against the _first_
  file's directory and breaks build contexts.
- **Workspace = service directory**: `dev-up` sets the workspace to the
  directory that contains `.devcontainer/`, not the git root. Git ops inside
  the container only work if `.git` is under that directory. To bring the
  whole repo in, change the workspace mount to `../..:/app` and
  `workspaceFolder` accordingly.
- **`name:` on volumes** is required for cross-project sharing. Without it,
  compose prefixes the project name and each project gets its own copy.
- **Alpine base images** won't work with the toolbox Dockerfile (uses apt).
  Either use Debian/Ubuntu bases or write an alpine variant.
- **`dotfiles-box` rebuild** is needed when the toolbox Dockerfile, dotfiles
  install script, or installed tools change. Project images built `--from`
  another base are independent — rebuild them when their base changes.

## Adding a new language toolchain

You don't need to update any scripts. Two options:

1. **One-shot dev image**: `dev-build --from <upstream> --tag <something>-dev`,
   reference it in project compose.
2. **Custom Dockerfile**: drop a `.devcontainer/Dockerfile.dev` in the project
   that does `FROM dotfiles-box` (or any other image) and adds the toolchain.
   Replace `image:` with `build:` in compose.yml.
