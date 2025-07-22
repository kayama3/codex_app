# ToDo CLI (File-based)

This is a simple command line tool for managing tasks stored in `tasks.json`.

## Usage

```
ruby todo/main.rb COMMAND [ARGS...]
```

Commands:

- `list` - show all tasks
- `add "title"` - add a new task
- `edit ID "new title"` - change task title
- `delete ID` - delete a task
- `toggle ID` - toggle completion state

A `tasks.json` file will be created automatically on first run.
