# bento-action

[![r2c community slack](https://img.shields.io/badge/r2c_slack-join-brightgreen?style=for-the-badge&logo=slack&labelColor=4A154B)](https://join.slack.com/t/r2c-community/shared_invite/enQtNjU0NDYzMjAwODY4LWE3NTg1MGNhYTAwMzk5ZGRhMjQ2MzVhNGJiZjI1ZWQ0NjQ2YWI4ZGY3OGViMGJjNzA4ODQ3MjEzOWExNjZlNTA)

This GitHub Action reviews pull requests with [Bento](https://github.com/returntocorp/bento)
whenever a new commit is added to them.
It reports as failed if there are any new bugs
that first appeared in that pull request.

## Usage

To start checking all pull requests,
add the following file at `.github/workflows/bento.yml`:

```yaml
name: Bento
on: [pull_request]
jobs:
  bento:
    runs-on: ubuntu-latest
    name: Check
    steps:
    - uses: actions/checkout@v1
    - name: Bento
      id: bento
      uses: returntocorp/bento-action@v1
      with:
        acceptTermsWithEmail: <add your email here>
```

To use Bento, you must accept [our Terms of Service & Privacy Policy](https://bento.dev/privacy)
by specifying your email address.
This email will be used to provide support and share product updates
— you can unsubscribe at any time.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
