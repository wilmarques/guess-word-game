# Execute Flutter commands for Flutter Web

Execute the given command on `args` using the Flutter CLI.

Currently, it only supports Flutter Web.

## Example usage

```diff
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
+     - name: Build Flutter Web
+       uses: ./.github/actions/execute-flutter-web-action
+       with:
+         args: build web
```
