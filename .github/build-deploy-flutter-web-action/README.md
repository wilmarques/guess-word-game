# Hello world docker action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

## `command`

**Required** Command to execute on Flutter CLI. Default `doctor`.

<!-- ## Outputs -->
<!-- ## `time` -->
<!-- The time we greeted you. -->

## Example usage

uses: actions/build-deploy-flutter-web-action
with:
  command: 'build web'
