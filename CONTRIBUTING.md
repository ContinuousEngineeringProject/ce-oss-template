# ${GITHUB_PROJECT_NAME}
Want to hack on the ${GITHUB_PROJECT_NAME}? Awesome! This page contains information that will help you contribute to the project.

There are two ways you can contribute to the project.

1. [Raise a new issue](#raise-a-new-issue). This could be for a new feature, bug, documentation change, or just a comment to an exising issue.
2. [Update the codebase](#update-the-codebase). This could be for a new feature, bug, or documentation change to an existing item on the backlog.


## Raise a new issue
Great you wish to help improve the project either with an idea, problem, or documentation change you have come up with. To do this you will need to raise a [new issue](https://github.com/${GITHUB_ORG}/${GITHUB_ISSUE_REPO}/issues/new/choose), and then select one of the issue types you can raise.

The moderators of the project could reach out to you, to discuss the issue you raised, during the review stage. 

You can track you issue on the Issue Kanban board [here](https://github.com/orgs/${GITHUB_ORG}/projects/8/views/1).

## Update the codebase
Contributing to the codebase is a three-step process, once you have selected an issue from the [ready backlog](https://github.com/orgs/${GITHUB_ORG}/projects/8/views/29) to work on. 

- [Code](#code)
- [Review](#review)
- [Merge](#merge)

### Prerequisites
The following prerequisites must be installed in your development environment:

<!-- 
  ToDo: Insert the prerequisites as bullet points.
-->

### Code
The expected outcomes are:
- Developed change to the codebase. See the [Development Guide](./docs/contributors/DEV_GUIDE.md) for more information.
- Developed new or updated tests for the change made. See the [Test Guide](./docs/contributors/TEST_GUIDE.md) for more information.
- Updated the documentation for the change made. See the [Documentation Guide](./docs/contributors/DOC_GUIDE.md) for more information.
- The `scripts/ci.sh` script has been successfully run for the change made. See the [pre pull request checks](./docs/contributors/DEV_GUIDE.md#pre-pull-request-checks) section for more information.

### Review
The expected outcomes are:
- Pull request is submitted for the change. See the [Pull Request Guide][pr-guide] before submitting a pull request.
- Automated checks all pass. See the [Automated Pull Request Checks](./docs/contributors/PR_GUIDE.md#automated-pull-request-checks) section for more information.
- Maintainers have successfully reviewed the pull request


### Merge
The factory (well, Tide, a component of Jenkins X) won't merge your changes until it has the tests passing against the *current* `HEAD` of `main` - but don't worry, whilst the tests *continue* to pass it will automatically merge your pull request into main and rerun the tests. As you can imagine, this can take a little while if the merge queue is long. Tide will also automatically attempt to batch up passing changes, but if the batch fails, it will resort to merging the pull requests one by one.

If the retest against `HEAD` of `main` fail, then it will notify you on the pull request, and you'll need to make some changes (and potentially get a new LGTM). See the [Testing and Merge Workflow](/docs/contributors/PR_GUIDE.md#the-testing-and-merge-workflow) section for more information.


[pr-guide]: ./docs/contributors/PR_GUIDE.md