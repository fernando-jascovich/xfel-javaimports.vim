# xfel Java Imports

This is a very simple plugin for having a super lightweight import management on java or kotlin files.

## What

An in-disk cache (json formmated) of imports. With class name as key and fully qualified class name as value.
That's all, this plugin will insert required import on the top of the file (one line after `package...` line).
If that class name has no entry in cache, you'll be prompted for providing manually that information.
If that import is already present on the file, an error message will be echoed.

## Commands

| Command    | Description                           |
| ---        | ---                                   |
| `:XFELJI`  | Main entry point  for this plugin     |
| `:XFELJIO` | Override any previously stored import |

