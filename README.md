# bento-action

[![r2c community slack](https://img.shields.io/badge/r2c_slack-join-brightgreen?style=for-the-badge&logo=slack&labelColor=4A154B)](https://join.slack.com/t/r2c-community/shared_invite/enQtNjU0NDYzMjAwODY4LWE3NTg1MGNhYTAwMzk5ZGRhMjQ2MzVhNGJiZjI1ZWQ0NjQ2YWI4ZGY3OGViMGJjNzA4ODQ3MjEzOWExNjZlNTA)

An easy way to run [Bento](https://github.com/returntocorp/bento) on your GitHub projects
to find bugs in open pull requests.

## Usage

```yaml
on: [pull_request]

jobs:
  bento:
    runs-on: ubuntu-latest
    name: Bento checks
    steps:
    - name: Bento checks
      id: bento
      uses: bento/bento-action@v1
```