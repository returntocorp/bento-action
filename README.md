# Bento Action

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

## Configuration

### Blocking Pull Requests

The Bento Action reports a failure to GitHub
if there are any new findings.
This is marked with a red :x: indicator on pull requests and commits.

If you'd like to disallow merging pull requests
when a Bento Action failure is present,
or in other words, set up blocking,
you can set this up on the Settings page of your repository,
under Branches › Branch protection rules.

### Slack Notifications

The Bento Action can notify you on Slack about findings.

1.  [Create a new incoming webhook](https://slack.com/apps/A0F7XDUAZ-incoming-webhooks)
    on your Slack workspace,
    and set the channel in which you'd like to receive notifications.
2.  [Add that URL as an encrypted secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets)
    for your GitHub repo, naming it `BENTO_SLACK_WEBHOOK_URL`.
3.  Change `.github/workflows/bento.yml` to pass the secret as a parameter when running Bento:

    ```yaml
      with:
        acceptTermsWithEmail: <add your email here>
        slackWebhookURL: ${{ secrets.BENTO_SLACK_WEBHOOK_URL }}
    ```


## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
