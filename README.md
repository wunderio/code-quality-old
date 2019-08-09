# Code Quality

This composer package will provide some basic code quality checks before commiting code.

It checks only modified files or new files.

## Checks performed

This repository currently has following checks:

* PHP Drupal Coding Standards
* PHP 7.1 Compatibility
* PHP syntax
* Shell script exec bits
* PHP Code security

## Pre-requisites

* Docker
* Composer

## Installation

This needs to be done only once either while creating a project or enabling code checks in existing project.

Include following things into your project to include `code-quality`:

```
{
    "minimum-stability": "dev",
    "repositories": {
        "code-quality": {
            "type": "vcs",
            "url": "git@github.com:wunderio/code-quality.git"
        }
    },
    "require-dev": {
        "wunderio/code-quality": "dev-master"
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

Running `composer install` will bring in new package and ensures git pre-commit hook by executing install-update.sh.

In future we will have it as regular composer package for easier installation.
