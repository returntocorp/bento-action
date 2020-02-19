# Contributing

## Upgrading to a new version of Bento

```pipenv update``` will update the version of Bento being used.

## Release

You can test the action at any commit or ref that exists in the repository.
Therefore, before production releases,
manually test the action with `returntocorp/bento-action@master`.

Once you're done running manual tests,
the following line will change all action runs to use your current `HEAD`:

``` 
git tag --force v1 && git push --tags --force
```
