# Development Guidelines
This doc explains the development guide for the project when contributing to the codebase. It should serve as a reference for all contributors, and be useful especially to new and infrequent submitters.

<!-- TOC -->
- [Git](#git)
  * [Commit message Guidelines](#commit-message-guidelines)
  * [Commit Sign-off](#commit-sign-off)
- [Pre-Pull Request checks](#pre-pull-request-checks)
  * [Linting](#linting)
  * [Static Code Analysis](#static-code-analysis)
<!-- /TOC -->

## Git
This section contains some guidelines for how to use git.

### Commit message Guidelines
The project uses [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) as it's commit message format. These are particularly important as semantic releases are in use, and they use the commit messages to determine the type of changes in the codebase. Following formalized conventions for commit messages the semantic release automatically determines the next [semantic version](https://semver.org) number and generates a changelog based on the conventional commit.

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The commit contains the following structural elements, to communicate intent:

1. Any line of the commit message cannot be longer 100 characters! This allows the message to be easier to read on GitHub as well as in various git tools.
2. The _description_ contains a succinct statement of the change. It should use the imperative, present tense: "change" not "changed" nor "changes", don't capitalize the first letter and no dot (.) at the end.
3. `fix:` a commit of the _type_ fix patches a bug in the codebase (this correlates with `PATCH` in Semantic Versioning).
4. `feat:` a commit of the _type_ `feat` introduces a new feature to the codebase (this correlates with `MINOR` in Semantic Versioning).
5. `BREAKING CHANGE:` a commit that has a _footer_ `BREAKING CHANGE:`, or appends a `!` after the _type/scope_, introduces a breaking API change (correlating with `MAJOR` in Semantic Versioning). A `BREAKING CHANGE` can be part of commits of any _type_.
6. _types_ other than `fix:` and `feat:` are allowed, such as `chore:`, `refactor:`, `test:`, `revert:` & `docs:` but will have no implicit effect in Semantic Versioning (unless they include a BREAKING CHANGE).
7. _footers_ other than `BREAKING CHANGE:` may be provided and follow a convention similar to [git trailer format](https://git-scm.com/docs/git-interpret-trailers).
8. A **scope** may be provided to a commit’s _type_, to provide additional contextual information and is contained within parenthesis, e.g., `feat(parser): add ability to parse arrays`.


### Commit Sign-off
A [Developer Certificate of Origin](https://en.wikipedia.org/wiki/Developer_Certificate_of_Origin) is required for all commits. It can be provided using the [sign-off](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---signoff) option for `git commit` or by GPG signing the commit. The developer certificate is available at (https://developercertificate.org/).

The project enforces the DCO using the [bot](https://github.com/probot/dco). You can view the details on the DCO check by viewing the `Checks` tab in the GitHub pull request.

![DCO sign-off check](https://user-images.githubusercontent.com/13410355/42352794-85fe1c9c-8071-11e8-834a-05a4aeb8cc90.png)

There are a couple of ways to ensure your commits are signed. Described below are three different ways to sign your commits: using git signoff, using GPG, or using webhooks.

#### Git sign-off
Git signoff adds a line to your commit message with the user.name and user.email values from your git config. Use git sign-off by adding the `--signoff` or `-s` flag when creating your commit. This flag must be added to each commit you would like to sign.

```sh
git commit -m -s "docs: my commit message"
```

If you'd like to keep your personal email address private, you can use a GitHub-provided `no-reply` email address as your commit email address. GitHub provides [good instructions on setting your commit email address](https://docs.github.com/en/github/setting-up-and-managing-your-github-user-account/setting-your-commit-email-address).

#### GPG sign your commits
A more secure alternative is to GPG sign all your commits. This has the advantage that as well as stating your agreement to the DCO it also creates a trust mechanism for your commits. There is a good guide from GitHub on how to set this up:

1) If you don't already have a GPG key, then follow [this guide to create one](https://help.github.com/en/articles/generating-a-new-gpg-key).

2) Now you have a GPG key, [tell GitHub about your key so that it can verify your commits](https://help.github.com/en/articles/adding-a-new-gpg-key-to-your-github-account). Once you upload your public gpg key to your GitHub account, GitHub will mark commits that you sign with the `verified` label.

3) To sign commits locally, you can add the `-S` flag when creating your commit. For more information on signing commits locally, follow [this guide to see how to sign your commit](https://help.github.com/en/articles/signing-commits).

4) You can configure git to always use signed commits by running

```sh
git config --global user.signingkey <key id>
```

The process to find the key id is described in [this guide on checking for existing GPG keys](https://help.github.com/en/articles/checking-for-existing-gpg-keys).

5) Set up a keychain for your platform. This is entirely optional but means you don't need to type your passphrase every time and allows git to run headless. If you are using a Mac GPG Suite is a good way to do this. If you are on another platform please open a PR against this document and add your recommendations!

#### Use a webhook to sign your commits
Alternatively, you can use a hook to make sure all your commits messages are signed off.

1) Run:
```sh
mkdir -p ~/.git-templates/hooks
```
```sh
git config --global init.templatedir ~/.git-templates
```

2) Then add this to `~/.git-templates/hooks/prepare-commit-msg`:

```bash
#!/bin/sh

COMMIT_MSG_FILE=$1  # The git commit file.
COMMIT_SOURCE=$2    # The current commit message.

# Add "Signed-off-by: <user> <email>" to every commit message.
SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
if test -z "$COMMIT_SOURCE"; then
/usr/bin/perl -i.bak -pe 'print "\n" if !$first_line++' "$COMMIT_MSG_FILE"
fi
```

3) Make sure the file is executable:
```sh
chmod u+x ~/.git-templates/hooks/prepare-commit-msg
```

4) Run `git init` on the repo you want to use the hook on.

Note that this will not override the hooks already defined on your local repo. It adds the `Signed-off-by: ...` line after the commit message has been created by the user.

- - -

## Pre-Pull Request checks
These checks outlined in this section should be run prior to raising a pull request.

### Linting

<!--
  ToDo: Add linting information
-->


### Static Code Analysis

<!--
  ToDo: Add Static Code Analysis information
-->
