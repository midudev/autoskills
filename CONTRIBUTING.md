# Contributing to AutoSkills

First off, thank you for considering contributing to AutoSkills! It's people like you that make open source such a great community.

## 1. Where do I go from here?

If you've noticed a bug or have a feature request, please [open an issue](../../issues) on GitHub. It's the best way to get things started.

## 2. Fork & create a branch

If this is something you think you can fix, then [fork AutoSkills](../../fork) and create a branch with a descriptive name.

A good branch name would be (where issue #325 is the ticket you're working on):

```sh
git checkout -b 325-add-new-feature
```

Or for a general fix:

```sh
git checkout -b fix/typo-in-readme
```

## 3. Implement your fix or feature

At this point, you're ready to make your changes! Feel free to ask for help on your PR if you get stuck.

## 4. Install Git hooks

Before committing, install the repository hooks:

```sh
pnpm run hooks:install
```

This configures Git to use the versioned hooks in `.githooks/`. The pre-commit hook formats staged files and adds the formatted result to the commit automatically.

## 5. Get the style right

Your patch should follow the same coding conventions and style as the rest of the project. Please ensure:

- Your code is properly linted and formatted before pushing.
- All new features and bug fixes include relevant tests.
- Existing tests pass locally before committing.

## 6. Make a Pull Request

At this point, you should switch back to your master branch and make sure it's up to date with the main repository:

```sh
git remote add upstream https://github.com/midudev/autoskills.git
git checkout main
git pull upstream main
```

Then update your feature branch from your local copy of main, and push it!

```sh
git checkout 325-add-new-feature
git rebase main
git push --set-upstream origin 325-add-new-feature
```

Finally, go to GitHub and create a Pull Request on the main repository.

## 7. Keeping your Pull Request updated

If an maintainer asks you to rebase, they're saying that a lot of code has changed, and that you need to update your branch to easily merge it into the main project.

Thank you for contributing!
