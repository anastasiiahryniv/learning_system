# README

## Rubocop
### console - run check:
```bash
bundle exec rubocop
```
### console - run check on specific file/folder:
### console - run check:
```bash
rubocop app/models/user.rb
```
### console - safe auto correct
```bash
rubocop -a
```
### console - dangerous auto correct
```bash
rubocop -A
```
### console - autocorrect a single specific cop
```bash
bundle exec rubocop -a --only Style/FrozenStringLiteralComment
bundle exec rubocop -A --only Layout/EmptyLineAfterMagicComment
```

## ERBLint
### find issues
```bash
bundle exec erblint --lint-all
```
### find issues and autocorrect
```bash
bundle exec erblint --lint-all --autocorrect
bundle exec erblint -la -a
```