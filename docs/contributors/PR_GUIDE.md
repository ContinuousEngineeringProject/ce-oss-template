# Pull Request Process
This doc explains the process and best practices for submitting a pull request for the project when contributing to the codebase. It should serve as a reference for all contributors, and be useful especially to new and infrequent submitters.

<!-- TOC -->ƒ

- [Before You Submit a Pull Request](#before-you-submit-a-pull-request)
  * [Pull Request message guidelines](#pull-request-message-guidelines) 
- [The Pull Request Submit Process](#the-pull-request-submit-process)
  * [Automated Pull Request Checks](#automated-pull-request-checks)
  * [The Testing and Merge Workflow](#the-testing-and-merge-workflow)
  * [Marking Unfinished Pull Requests](#marking-unfinished-pull-requests)
  * [Comment Commands Reference](#comment-commands-reference)
  * [How the Tests Work](#how-the-tests-work)
- [Why was my Pull Request closed?](#why-was-my-pull-request-closed)
- [Why is my Pull Request not getting reviewed?](#why-is-my-pull-request-not-getting-reviewed)
- [Best Practices for Faster Reviews](#best-practices-for-faster-reviews)
  * [1. Is the feature wanted? Create a Feature Request Issue](#1-is-the-feature-wanted-create-a-feature-request-issue)
  * [2. Smaller Is Better: Small Commits, Small Pull Requests](#2-smaller-is-better-small-commits-small-pull-requests)
  * [3. Open a Different Pull Request for Fixes and Generic Features](#3-open-a-different-pull-request-for-fixes-and-generic-features)
  * [4. Comments Matter](#4-comments-matter)
  * [5. Test](#5-test)
  * [6. Squashing and Commit Titles](#6-squashing-and-commit-titles)
  * [7. KISS, YAGNI, MVP, etc.](#7-kiss-yagni-mvp-etc)
  * [8. It's OK to Push Back](#8-its-ok-to-push-back)
  * [9. Common Sense and Courtesy](#9-common-sense-and-courtesy)
  * [10. Trivial Edits](#10-trivial-edits)

<!-- /TOC -->

## Before You Submit a Pull Request
Make sure your pull request adheres to our best practices. These include following project conventions, making small pull requests, and commenting thoroughly. Please read the more detailed section on [Best Practices for Faster Reviews](#best-practices-for-faster-reviews) at the end of this doc.

### Pull Request message guidelines
This project uses [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) as it's PR message format. These are particularly important as semantic releases are in use, and they use the PR message to determine the type of changes in the codebase. Following formalized conventions for PR messages the semantic release automatically determines the next [semantic version](https://semver.org) number and generates a changelog based on the conventional commit.

#### Pull Request Title
The pull request title should follow the below structured:

```md
<type>[optional scope]: <description> (<PR ID>)

e.g.
feat(parser): add ability to parse arrays (#123)
```

The pull request title contains the following structural elements, to communicate intent:

1. The _description_ contains a succinct statement of the change. It should use the imperative, present tense: "change" not "changed" nor "changes", don't capitalize the first letter and no dot (.) at the end.
2. `fix:` a pull request of the _type_ fix patches a bug in the codebase (this correlates with `PATCH` in Semantic Versioning).
3. `feat:` a pull request of the _type_ `feat` introduces a new feature to the codebase (this correlates with `MINOR` in Semantic Versioning).
4. `BREAKING CHANGE` is a pull request that appends a `!` after the _type/scope_, and correlates with a `MAJOR` in Semantic Versioning. A `BREAKING CHANGE` can be part of any PR _type_.
5. _types_ other than `fix:` and `feat:` are allowed, such as `chore:`, `refactor:`, `test:` & `docs:` but will have no implicit effect in Semantic Versioning (unless they include a BREAKING CHANGE).
6. A **scope** may be provided to the pull request’s _type_, to provide additional contextual information and is contained within parenthesis, e.g., `feat(parser): add ability to parse arrays`.

#### Pull Request Body
The pull request body should follow the below structure.

```md
## Pull Request Description
Include a summary of the change.

### Implementation
Include a summary of how the change was implemented.

### Dependencies
List any dependencies that are required for the change.

## Linked Issues
Use one or both of the following formats to link an issue to the PR, ${GITHUB_ORG}/issues#<issue number> or 
<close,closes,closed,fix,fixes,fixed,resolve,resolves,resolved> ${GITHUB_ORG}/issues#<issue-number>

To list multiple issues, separate them with a comma e.g. ${GITHUB_ORG}/issues#003, closed ${GITHUB_ORG}/issues#004
```

## The Pull Request Submit Process
Merging a pull request requires the following steps to be completed before the pull request will be merged automatically.

- [Open a pull request][How2PR]
- Pass all tests
- Get all necessary approvals from reviewers and owners 

### Automated Pull Request Checks
There are a number of automated checks that will run on your PR:

- _Semantic Pull Request_
  * validates that your commit messages meet the Conventional Commit format described above, additionally your PR must also have a conventional message. The UX for this bot is a little odd as it doesn't go red if the messages are NOT correct, instead it goes yellow. You need it to go to a green tick!
- _DCO_
  * see [Sign-off](./DEV_GUIDE.md#commit-sign-off)
- _Hound_
  * lints the code and comments inline with any issues. You need this to go to a green tick and say "No violations found. Woof!"
- _lint_
  * runs a lot more lint checks but in a CI job so won't provide inline feedback. You need this to pass as a green tick. Check the log for any errors.
- _tekton_
  * runs the end-to-end tests in a new cluster using tekton. Check the logs for errors.
- _integration_
  * runs all the tests that are inline in the codebase. Check the logs for errors.
- _tide_
  * performs the merge when all the checks pass. Don't worry about the state of this one, it doesn't add much info. Clicking on the details link is very helpful as it will take you to the dashboard where you can navigate to the "Tide" screen and check the status of your PR in the merge queue.

### The Testing and Merge Workflow

The merge workflow uses labels, applied by [commands][ChatOps] via comments. These will trigger actions on your pull request. Different ceProject repositories may require different labels on the path to approval. A generic explanation of how labels are used in pull requests can be found [here][Owners]. The pull request bot will also automatically apply and/or suggest labels.

*NOTE: For pull requests that are in progress but not ready for review, prefix the pull request title with `WIP` or `[WIP]` and track any remaining ToDos in a checklist in the pull request description.*

Here's the process the pull request goes through on its way from submission to merging:

1. Pull request submitted.
2. `${GITHUB_BOT_NAME}` assigns reviewers
3. If you're **not** a member of the Continuous Engineering Project organization, a Reviewer Member checks that the pull request is safe to test. If so, they comment `/ok-to-test`. Pull requests by  organization members do not need this step. Now the pull request is considered to be trusted.
4. The pre-submit tests will run:

    1. Automatic tests run.
    2. If tests fail, resolve issues by pushing edits to your pull request branch
    3. If the failure is a flake, anyone on trusted pull requests can comment `/retest` to rerun failed tests

5. Reviewer suggests edits
6. Push edits to your pull request branch
7. Repeat the prior two steps as needed until reviewer(s) add `/lgtm` label
8. You squash commits at this step
9. Follow the bot suggestions to assign an OWNER who will add the `/approve` label to the pull request

Once the tests pass, and the reviewer adds the `lgtm` and `approved` labels, the pull request enters the final merge pool. The merge pool is needed to make sure no incompatible changes have been introduced by other pull requests since the tests were last run on your pull request.

Tide will manage the merge pool automatically. It uses GitHub queries to select PRs into “tide pools”, runs as many in a batch as it can (“tide comes in”), and merges them (“tide goes out”).

1. The pull request enters the merge pool if the merge criteria are met
1. If tests fail, resolve issues by pushing edits to your pull request branch
1. If the failure is a flake, anyone can comment `/retest` if the pull request is trusted
1. If tests pass, Tide automatically merges the pull request

That's the last step. Your pull request is now merged.

### Marking Unfinished Pull Requests

If you want to solicit reviews before the implementation of your pull request is complete, you should hold your pull request to ensure that Tide does not pick it up and attempt to merge it. There are two methods to achieve this:

1. You may add the `/hold` or `/hold cancel` comment commands
2. You may add or remove a `WIP` or `[WIP]` prefix to your pull request title

The GitHub robots will add and remove the `do-not-merge/hold` label as you use the comment commands and the `do-not-merge/work-in-progress` label as you edit your title. While either label is present, your pull request will not be considered for merging.

### Comment Commands Reference

[The commands' doc][ChatOps] contains a reference for all comment commands.


### How the Tests Work

The end-to-end tests will post the status results to the pull request. If an e2e test fails,
`${GITHUB_BOT_NAME}` will comment on the pull request with the test history and the
comment-command to re-run that test. e.g.

> The following tests failed, say /retest to rerun them all.

## Why was my pull request closed?

Pull requests older than 90 days will be closed. Exceptions can be made for pull requests that have active review comments, or that are awaiting other dependent pull requests. Closed pull requests are easy to recreate, and little work is lost by closing a pull request that subsequently needs to be reopened. We want to limit the total number of pull requests in flight to:
* Maintain a clean project
* Remove old pull requests that would be difficult to rebase as the underlying code has changed over time
* Encourage code velocity

## Why is my pull request not getting reviewed?

A few factors affect how long your pull request might wait for review.

If it's the last few weeks of a milestone, we need to reduce churn and stabilize.

Or, it could be related to best practices. One common issue is that the pull request is too big to review. Let's say you've touched 39 files and have 8657 insertions. When your would-be reviewers pull up the diffs, they run away - this pull request is going to take 4 hours to review, and they don't have 4 hours right now. They'll get to it later, just as soon as they have more free time (ha!).

There is a detailed rundown of best practices, including how to avoid too-lengthy pull requests, in the next section.

But, if you've already followed the best practices, and you still aren't getting any pull request love, here are some things you can do to move the process along:

   * Make sure that your pull request has an assigned reviewer (assignee in GitHub). If not, reply to the pull request comment stream asking for a reviewer to be assigned. This is done via a [bot command][ChatOps] (the bot may have suggestions for this) and looks like this: `/assign @username`.

   * Ping the assignee (@username) on the pull request comment stream, and ask for an estimate of when they can get to the review.

   * Ping the assignee on [Slack][Slack]. Remember that a person's GitHub username might not be the same as their Slack username.

   * Ping the assignee by email (many of us have publicly available email addresses).

   * If you're a member of the organization ping the [team][GitHubTeam] (via @team-name) that works in the area you're submitting code.

   * If you have fixed all the issues from a review, and you haven't heard back, you should ping the assignee on the comment stream with a "please take another look" (`PTAL`) or similar comment indicating that you are ready for another review.

Read on to learn more about how to get faster reviews by following best practices.

## Best Practices for Faster Reviews

You've just had a brilliant idea on how to make project better. Let's call that idea Feature-X. Feature-X is not even that complicated. You have a pretty good idea of how to implement it. You jump in and implement it, fixing a bunch of stuff along the way. You send your pull request - this is awesome! And it sits. And sits. A week goes by and nobody reviews it. Finally, someone offers a few comments, which you fix up and wait for more review. And you wait. Another week or two go by. This is horrible.

Let's talk about best practices so your pull request gets reviewed quickly.


### 1. Is the feature wanted? Create a Feature Request Issue
Are you sure Feature-X is something the project team wants or will accept? Is it implemented to fit with other changes in flight? Are you willing to bet a few days or weeks of work on it?

It's better to get confirmation beforehand.

Even for small changes, it is often a good idea to gather feedback on an issue you filed, or even simply ask in the appropriate Slack channel to invite discussion and feedback from code owners.


### 2. Smaller Is Better: Small Commits, Small Pull Requests

Small commits and small pull requests get reviewed faster and are more likely to be correct than big ones.

Attention is a scarce resource. If your pull request takes 60 minutes to review, the reviewer's eye for detail is not as keen in the last 30 minutes as it was in the first. It might not get reviewed at all if it requires a large continuous block of time from the reviewer.

**Breaking up commits**

Break up your pull request into multiple commits, at logical break points.

Making a series of discrete commits is a powerful way to express the evolution of an idea or the different ideas that make up a single feature. Strive to group logically distinct ideas into separate commits.

For example, if you found that Feature-X needed some refactoring to fit in, make a commit that JUST does that refactoring. Then make a new commit for Feature-X.

Strike a balance with the number of commits. A pull request with 25 commits is still very cumbersome to review, so use judgment.

**Breaking up Pull Requests**

Or, going back to our refactoring example, you could also fork a new branch, do the refactoring there and send a pull request for that. If you can extract whole ideas from your pull request and send those as pull requests of their own, you can avoid the painful problem of continually rebasing.

The project has a fast-moving codebase - lock in your changes ASAP with your small pull request, and make merges be someone else's problem.

Multiple small pull requests are often better than multiple commits. Don't worry about flooding us with pull requests. We'd rather have 100 small, obvious pull requests than 10 un-reviewable monoliths.

We want every pull request to be useful on its own, so use your best judgment on what should be a pull request vs. a commit.

As a rule of thumb, if your pull request is directly related to Feature-X and nothing else, it should probably be part of the Feature-X pull request. If you can explain why you are doing seemingly no-op work ("it makes the Feature-X change easier, I promise") we'll probably be OK with it. If you can imagine someone finds value independently of Feature-X, try it as a pull request. (Do not link pull requests by `#` in a commit description, because GitHub creates lots of spam. Instead, reference other pull requests via the pull request your commit is in.)

### 3. Open a Different pull request for Fixes and Generic Features

**Put changes that are unrelated to your feature into a different pull request.**

Often, as you are implementing Feature-X, you will find bad comments, poorly named functions, bad structure, weak type-safety, etc.

You absolutely should fix those things (or at least file issues, please) - but not in the same pull request as your feature. Otherwise, your diff will have way too many changes, and your reviewer won't see the forest for the trees.

**Look for opportunities to pull out generic features.**

For example, if you find yourself touching a lot of modules, think about the dependencies you are introducing between packages. Can some of what you're doing be made more generic and moved up and out of the Feature-X package? Do you need to use a function or type from an otherwise unrelated package? If so, promote! We have places for hosting more generic code.

Likewise, if Feature-X is similar in form to Feature-W which was checked in last month, and you're duplicating some tricky stuff from Feature-W, consider refactoring the core logic out and using it in both Feature-W and Feature-X. (Do that in its own commit or pull request, please.)

### 4. Comments Matter

In your code, if someone might not understand why you did something (or you won't remember why later), comment it. Many code-review comments are about this exact issue.

If you think there's something pretty obvious that we could follow up on, add a TODO.


### 5. Test

Nothing is more frustrating than starting a review, only to find that the tests are inadequate or absent. Very few pull requests can touch code and NOT touch tests.

If you don't know how to test Feature-X, please ask!  We'll be happy to help you design things for easy testing or to suggest appropriate test cases.

### 6. Squashing and Commit Titles

Your reviewer has finally sent you feedback on Feature-X.

Make the fixes, and don't squash yet. Put them in a new commit, and re-push. That way your reviewer can look at the new commit on its own, which is much faster than starting over.

We might still ask you to clean up your commits at the very end for the sake of a more readable history, but don't do this until asked: typically at the point where the pull request would otherwise be tagged `LGTM`.

Follow the [Commit message guidelines](./DEV_GUIDE.md#commit-message-guidelines) for your commit title.
Each commit should have a good title line (<70 characters) and include an additional description paragraph describing in more detail the change intended.

**General squashing guidelines:**

* Sausage => squash

Do squash when there are several commits to fix bugs in the original commit(s), address reviewer feedback, etc. Really we only want to see the end state and commit message for the whole pull request.

* Layers => don't squash

Don't squash when there are independent changes layered to achieve a single goal. For instance, writing a code nugget could be one commit, applying it could be another, and adding a pre-commit check could be a third. One could argue they should be separate pull requests, but there's really no way to test/review the nugget without seeing it applied, and there needs to be a pre-commit check to ensure the munged output doesn't immediately get out of date.

A commit, as much as possible, should be a single logical change.

### 7. KISS, YAGNI, MVP, etc.

Sometimes we need to remind each other of core tenets of software design - Keep It Simple, You Aren't Gonna Need It, Minimum Viable Product, and so on. Adding a feature "because we might need it later" is antithetical to software that ships. Add the things you need NOW and (ideally) leave room for things you might need later - but don't implement them now.

### 8. It's OK to Push Back

Sometimes reviewers make mistakes. It's OK to push back on changes your reviewer requested. If you have a good reason for doing something a certain way, you are absolutely allowed to debate the merits of a requested change. Both the reviewer and reviewer should strive to discuss these issues in a polite and respectful manner.

You might be overruled, but you might also prevail. We're pretty reasonable people. Mostly.

Another phenomenon of open-source projects (where anyone can comment on any issue) is the dog-pile - your pull request gets so many comments from so many people it becomes hard to follow. In this situation, you can ask the primary reviewer (assignee) whether they want you to fork a new pull request to clear out all the comments. You don't HAVE to fix every issue raised by every person who feels like commenting, but you should answer reasonable comments with an explanation.

### 9. Common Sense and Courtesy

No document can take the place of common sense and good taste. Use your best judgment, while you put a bit of thought into how your work can be made easier to review. If you do these things your pull requests will get merged with less friction.

### 10. Trivial Edits

Each incoming Pull Request needs to be reviewed, checked, and then merged.

While automation helps with this, each contribution also has an engineering cost. Therefore, it is appreciated if you do NOT make trivial edits and fixes, but instead focus on giving the entire file a review.

If you find one grammatical or spelling error, it is likely there are more in that file, you can really make your Pull Request count by checking formatting, checking for broken links, and fixing errors and then submitting all the fixes at once to that file.

**Some questions to consider:**

* Can the file be improved further?
* Does the trivial edit greatly improve the quality of the content?


[Owners]: OWNERS_SPEC.md#code-review-using-owners-files
[How2PR]: https://help.github.com/articles/about-pull-requests/
[Slack]: https://${SLACK_WORKSPACE}.slack.com
[GitHubTeam]: https://github.com/orgs/${GITHUB_ORG}/teams
[ChatOps]: https://jenkins-x.io/v3/develop/reference/chatops/


