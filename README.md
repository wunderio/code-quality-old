# Code Quality

This composer package will provide some basic code quality checks before committing code.

It checks ONLY git staged.

## Checks performed

This repository currently has following checks

- [ESLint](https://eslint.org/) validator

## Pre-requisites

- Node.js
- Npm or Yarn

## Installation

### Existing project
- Copy dot files over your project or make your own. Just make sure **eslint** is installed.

- Add these lines to your **package.json**

```
"husky": {
    "hooks": {
        "pre-commit": "lint-staged"
    }
},
"lint-staged": {
    "*.{js}": [
        "eslint"
    ]
}
```

- Install required packages:
```
npm install --save-dev lint-staged husky
```

- Now all should be ready, go ahead and test it:
```
git add ./src/demo.js
git commit
```

### New project
@todo