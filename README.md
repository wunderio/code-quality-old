# code-quality

Include following things into your project to include `code-quality`:

```
{
    "require": {
        "wunderio/code-quality": "master"
    },
    "minimum-stability": "dev",
    "repositories": {
        "code-quality": {
            "type": "vcs",
            "url": "git@github.com:wunderio/code-quality.git"
        }
    },
    "scripts": {
      "post-install-cmd": [
        "./vendor/wunderio/code-quality/install-update.sh"
      ],
      "post-update-cmd": [
        "./vendor/wunderio/code-quality/install-update.sh"
      ]
    }
}
```

In future we will have it as regular composer package for easier installation.
