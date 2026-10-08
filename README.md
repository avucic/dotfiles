# dotfiles

## Todo due-date notifications (macOS)

`bin/bin/todo-notify` scans `$TODO_FILE` (todo.txt format, managed with
[tuxedo](https://github.com/webstonehq/tuxedo)) for `due:YYYY-MM-DD` tasks
and fires a native macOS notification once per day per task, via a
`launchd` agent that runs every 5 minutes.

Notifications are fired with `osascript -e 'display notification ...'`
(attributed to "Script Editor" in Notification Center), **not**
`terminal-notifier` — that was tried first since it's the usual
recommendation for cron/launchd notifications, but Homebrew's build is
only ad-hoc signed with no Team ID, so Gatekeeper rejects it outright
(`spctl -a -vv` → `rejected`) and it can't register for notification
permission at all on current macOS. Plain `osascript` works fine from
launchd and needs no extra permission beyond Script Editor's own
Notification Center entry.

By default the banner uses the "Banners" style, which auto-dismisses after
a few seconds. To make it stick around until dismissed: System Settings →
Notifications → Script Editor → Alert Style → **Alerts**.

Due-date tasks can carry a time of day with a custom `at:HH:MM` tag, e.g.:

```
2026-10-09 sastanak sa timom due:2026-10-09 at:15:00
```

`at:` is a plain extension tag — tuxedo doesn't recognize it, so it's never
rewritten or validated (unlike tuxedo's own `t:` key, which means
"threshold offset", e.g. `t:-3d`, *not* a time of day — don't confuse the
two).

### Setup on a new machine

1. Stow the `bin` package so `~/bin/todo-notify` exists (symlinked from
   `bin/bin/todo-notify`).
2. Create `~/Library/LaunchAgents/com.vucinjo.todo-notify.plist` (not
   tracked in this repo — LaunchAgents aren't stow-managed):

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
     <key>Label</key>
     <string>com.vucinjo.todo-notify</string>
     <key>ProgramArguments</key>
     <array>
       <string>/Users/vucinjo/bin/todo-notify</string>
     </array>
     <key>EnvironmentVariables</key>
     <dict>
       <key>TODO_FILE</key>
       <string>/Users/vucinjo/Documents/Notes/todos/todo.txt</string>
     </dict>
     <key>StartInterval</key>
     <integer>300</integer>
     <key>RunAtLoad</key>
     <true/>
     <key>StandardErrorPath</key>
     <string>/Users/vucinjo/.cache/todo-notify/stderr.log</string>
   </dict>
   </plist>
   ```

   `TODO_FILE` is set explicitly here because launchd agents don't source
   `~/.zshrc` / `~/.env`, so the var isn't otherwise available to them.

3. Grant Full Disk Access to `/opt/homebrew/bin/bash`: System Settings →
   Privacy & Security → Full Disk Access → `+` → `Cmd+Shift+G` →
   `/opt/homebrew/bin/bash` → enable. Required because `todo.txt` lives
   under `~/Documents`, which is TCC-protected. The script's shebang is
   pinned to `#!/opt/homebrew/bin/bash` rather than `#!/usr/bin/env bash`
   on purpose: granting Full Disk Access to the system `/bin/bash` was
   tried first and the toggle *looked* enabled, but silently had no effect
   even after `sudo killall tccd` and a reboot — current macOS appears to
   ignore FDA grants on SIP-protected system binaries. Homebrew's bash is
   a normal, unprotected binary and the grant works correctly for it.
4. Load the agent:

   ```sh
   launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.vucinjo.todo-notify.plist
   ```

   Check it's running: `launchctl list | grep todo-notify` (last column is
   the last exit status; `0` is healthy). Logs/errors land in
   `~/.cache/todo-notify/stderr.log`.
