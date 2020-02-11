# bento-action

[![r2c community slack](https://img.shields.io/badge/r2c_slack-join-brightgreen?style=for-the-badge&logo=slack&labelColor=4A154B)](https://join.slack.com/t/r2c-community/shared_invite/enQtNjU0NDYzMjAwODY4LWE3NTg1MGNhYTAwMzk5ZGRhMjQ2MzVhNGJiZjI1ZWQ0NjQ2YWI4ZGY3OGViMGJjNzA4ODQ3MjEzOWExNjZlNTA)

An easy way to run [Bento](https://github.com/returntocorp/bento) on your GitHub projects
to find bugs in open pull requests.

## Usage

To check all pull requests, add the following file at `.github/workflows/bento.yml`:

```yaml
name: Bento
on: [pull_request]
jobs:
  bento:
    runs-on: ubuntu-latest
    name: Bento checks
    steps:
    - uses: actions/checkout@v1
    - name: Bento checks
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

### Release

The following line will change all action runs to use your current `HEAD`.

``` 
git tag --force v1 && git push --tags --force
```