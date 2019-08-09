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

* Composer

## Installation

This needs to be done only once either while creating a project or enabling code checks in existing project.

1. Include following into `composer.json`:

```
{
    "minimum-stability": "dev"
}
```

2. `composer require wunderio/code-quality`

3. Link maintenance script in `composer.json`:
```
{
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

4. `composer update` or `composer install`

When a developer pulls a project containing code-quality:

1. Running `composer update` or `composer install` will bring in new package and ensures git pre-commit hook by executing `install-update.sh`.

## Custom PHP CodeSniffer rules

If you need to customize the rules for PHP CodeSniffer then drop in phpcs.xml in the same
folder as composer.json.

## Usage

The pre-commit hook will be automatically run upon executing `git commit`.

The code scanning can be avoided by `git commit --no-verify`.

Files can be scanned individually: `pre-commit myfile.php`.
