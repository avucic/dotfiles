#!/usr/bin/env python3

import argparse
import sys
import os
import re
from subprocess import call, run
from random import getrandbits
from hashlib import sha256
from fileinput import FileInput
from contextlib import contextmanager
from dataclasses import dataclass
from typing import Optional
from pathlib import Path

NOTE_ID_PATTERN = re.compile(r'note:(?P<note_id>[a-zA-Z0-9]+)')

@dataclass
class Task:
    id: int
    original_content: str
    note_id: int = None


def parse_task(task_id: int, original_content: str) -> Task:
    """Returns a new `Task` from the id and the original content in todo.md

    This function will look for the tag `note:XXXX` which contains the id of
    the description generated by this plugin.
    """
    match = NOTE_ID_PATTERN.search(original_content)
    if match and match.group('note_id'):
        note_id = match.group('note_id')
        return Task(
            id=task_id,
            original_content=original_content,
            note_id=note_id
        )
    return Task(id=task_id, original_content=original_content)

def get_task(task_id: int) -> Optional[Task]:
    """Reads the whole content of the task in todo.md file
    """

    with todotxt() as todo_file:
        for i, line in enumerate(todo_file):
            line: str = line
            if i == task_id - 1:
                return parse_task(task_id, line)

    return None

@contextmanager
def todotxt(write: bool = False):
    todo_file = os.getenv('TODO_FILE')
    try:
        f = open(todo_file, 'w' if write else 'r')
        yield f
    finally:
        f.close()

def get_note_file(note_id: int) -> Path:
    note_dir: Path = Path(os.getenv('TODO_DIR')) / 'notes'

    if not note_dir.exists():
        note_dir.mkdir()

    if not note_dir.is_dir():
        raise ValueError(f"{note_dir} is not a directory")

    description_file: Path = note_dir / f"{note_id}.md"

    return description_file

def get_note_content(note_id: int) -> str:
    note_file = get_note_file(note_id)

    if not note_file.is_file():
        raise ValueError(f"{note_file} is not a file")

    with open(note_file, 'r') as df:
        return "".join(df.readlines())

def __edit_using_editor(note_file: str):
    editor = os.getenv('EDITOR', os.getenv('TODO_NOTE_EDITOR', 'vi'))
    # The $EDITOR may be set with a value containing space(s) (probrably to set
    # the editor's arguments. For examples: `vim --noplugin` or `emacs -nw`.
    # In this case, we split the space so that the executable is always the first
    # argument to  subprocess.call().
    commands = editor.split(' ')
    commands.append(note_file)
    return call(commands)

def edit_note(task_id: int) -> None:
    task = get_task(task_id)

    if task is None:
        raise ValueError(f"Task #{task_id} not found in todo.md")

    if task.note_id:
        note_file = get_note_file(task.note_id)
        __edit_using_editor(note_file)
    else:
        raise ValueError(f"No description found for task {task_id}")


def add_note(task_id: int, note: str) -> None:
    task = get_task(task_id)

    if task is None:
        raise ValueError(f"Task #{task_id} not found in todo.md")

    if task.note_id is not None:
        raise ValueError(f"Task #{task_id} already has a note")

    note_dir: Path = Path(os.getenv('TODO_DIR')) / 'notes'

    if not note_dir.is_dir():
            raise ValueError(f"{note_dir} is not a directory")

    # NOTE:
    # ----
    # Use SHA256 to hash the random string generated by `getrandbits()``
    # The hash in HEX is truncated to get the first 8 charaters. (like a Git commit)
    note_id = sha256(str(getrandbits(256)).encode('utf-8')).hexdigest()[:8]

    note_file: Path = note_dir / f"{note_id}.md"

    if note:
        with open(note_file, "w", encoding="utf-8") as nf:
            nf.write(note)
    else:
        return_code = __edit_using_editor(note_file)

        if return_code != 0 or not os.path.exists(note_file):
            print("Note is aborted")

    with FileInput(os.getenv('TODO_FILE'), inplace=True, mode="r", backup=".bak") as todo:
        for index, line in enumerate(todo, start=1):
            if index == task_id:
                trip_existing_note = re.sub(NOTE_ID_PATTERN.pattern, '', line)
                print(f"{trip_existing_note.strip()} note:{note_id}")
            else:
                print(line, end='')

def show_note(task_id: int) -> None:
    """Prints the note associcating with the `task_id`
    """
    task = get_task(task_id)

    if task is None:
        raise ValueError(f"Task #{task_id} not found in todo.md")

    if task.note_id:
        note_full = get_note_content(task.note_id)
        print(note_full)
    else:
        raise ValueError(f"No description found for task {task_id}")

def remove_note(task_id: int) -> None:
    """Removes the note associcating with the `task_id`
    """
    task = get_task(task_id)
    note_dir: Path = Path(os.getenv('TODO_DIR')) / 'notes'

    if task is None:
        raise ValueError(f"Task #{task_id} not found in todo.md")

    if task.note_id:
        note_full = get_note_content(task.note_id)
    else:
        raise ValueError(f"No description found for task {task_id}")

    while True:
        confirm = input('Are you sure? (y/n) ')
        if confirm.strip().lower() in ('y', 'yes'):
            note_file: Path = note_dir / f"{task.note_id}.md"
            if os.path.isfile(note_file):
                os.remove(note_file)

                with FileInput(os.getenv('TODO_FILE'), inplace=True, mode="r", backup=".bak") as todo:
                    for index, line in enumerate(todo, start=1):
                        if index == task_id:
                            trip_existing_note = re.sub(NOTE_ID_PATTERN.pattern, '', line)
                            print(f"{trip_existing_note.strip()}")
                        else:
                            print(line, end='')
            break
        else:
            break



def optionally_from_stdin(input):
    """Parse the command line arguments to check whether to read the `description`
    value as is or takes from /dev/stdin (data are piped in)
    """
    if input == "-":
        return "".join(sys.stdin.readlines()).strip()
    if isinstance(input, str):
        return input
    return str(input)


def main(arguments: list):
    parser = argparse.ArgumentParser(prog="todo-note")
    sub_parsers = parser.add_subparsers()

    add_des_parser = sub_parsers.add_parser(
        name="add",
        aliases=['a'],
        help="Add a note to a task")

    add_des_parser.add_argument(
        "task_id",
        help="todo.md task id",
        type=int)

    add_des_parser.add_argument(
        "-n",
        "--note",
        help="""
        Note for the task. Use - if you want to read from stdin
        """,
        required=False,
        type=optionally_from_stdin)

    show_des_parser = sub_parsers.add_parser(
        name="show",
        aliases="s",
        help="Show task's note")


    show_des_parser.add_argument(
        "task_id",
        help="todo.md task id",
        type=int)

    edit_des_parser = sub_parsers.add_parser(
        name="edit",
        aliases=['e'],
        help="Edit the task's note"
    )

    edit_des_parser.add_argument(
        "task_id",
        help="todo.md task id",
        type=int)

    remove_des_parser = sub_parsers.add_parser(
        name="del",
        aliases="d",
        help="remove task's note")

    remove_des_parser.add_argument(
        "task_id",
        help="todo.md task id",
        type=int)


    show_des_parser.set_defaults(func=show_note)
    remove_des_parser.set_defaults(func=remove_note)
    add_des_parser.set_defaults(func=add_note)
    edit_des_parser.set_defaults(func=edit_note)

    parsed_args: dict = parser.parse_args(None if arguments else ['-h'])
    input = dict(vars(parsed_args))
    if 'func' in input:
        del input['func']
        parsed_args.func(**input)

if __name__ == "__main__":
    try:
        main(sys.argv[1:])
    except ValueError as e:
        print(e)
        sys.exit(1)