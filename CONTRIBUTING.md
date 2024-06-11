# Contributing
Hello there, were happy you like to join the project 🦆. This document was made to describe our workflow within this project in order to hopefully prevent things from going tooooo much haywire within this project. So please check it out! 

## Git Workflow

### Branching

#### Master Branch

The **Master Branch** is sacred 🙏 , it's code that is always working and deployable. You should never work directly on master and never push to it from a local version or from any branch other than the origin dev. You also generally shouldn't be pushing to the holy **Master branch** unless you are about to make a release!

#### Dev Branch

The **Dev branch** is where you branch off and merge in most of your code, it should be ahead of the latest release to master and should attempt to always be working. If something does break then you want to fix it as soon as possible.

#### Feature Branches

Each new feature should reside in its own branch. But, instead of branching off of **Master**, feature branches use **Dev** as their parent branch. When a feature is complete, it gets merged back into **Dev**. Features should never interact directly with **Master**. You make pull requests into it before making a Merge request into **Dev**.

Feature branches should be named: `feat/[branch_name]`

##### Create new Feature Branch:

1. Update the \*_dev_ branch to latest version
-   Always branch from the place it will be merged back into

2. Create branch
-   short descriptive name
-   prefixed with feature-keyword (eg. `feat/[branch_name]`)

```sh
  git checkout dev
  git checkout -b feat/[branch_name]
```

Sometimes new features take several team members to create. In these cases **Sub-Feature branches** can be used (if really needed :D ). In this case a feature branch is similar to the **Dev branch** in that you never directly write code to it, if not necessary.

Sub-Feature branches should be named: `[initials]/feat/[branch_name]`


### Commit Convention
Your commit messages should describe what functionality the code or new feature provides instead of describing what you did to the code. Your commit description should complete the folowing sentence "If applied, this commit will `<your commit line here>`. 

A commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The `<type>` and `<summary>` fields are mandatory, the (`<scope>`) field is optional.

**Types:**

- **fix:** a bug fix
- **feat:** a new feature
- **docs:**  documentation, comments
- **style:** introduces new styling
- **refactor:** restructure of existing code
- **test:** add tests or correcting existing tests
- **perf:** code change that improves performance
- **ci:** CI configuration changes
- **build:** build system or external dependencies

**Optional Scopes:**
- compiler
- compiler-cli
- core
- directus-sdk
- router
- store
- service-worker
- ...

Further scopes possible (e.g. for packages, release notes ...).

**Breaking Changes:**
A commit that has a footer BREAKING CHANGE:, or appends a ! after the type/scope, introduces a breaking change. A BREAKING CHANGE can be part of commits of any type.

e.g.

```
feat(api)!: support for Node 6
```

### Merge Request Process
1. Create Issue for the new feature 
2. Create Merge Request from the Issue
3. Commit Changes to the new branch

#### Code Review

1. Other devs (in any case the assigned reviewer) should review code and leave notes
2. Code owner is responsible for making any necessary fixes any pushing them up
3. Other devs should give the code the thumbs up (at least one other dev)
	- Literally leave a comment with an emoji thumbs up 👍

#### Merging Code

Once you have had enough people reviewed it, you are confident in the code you have written, and everything is well tested and passing. You can start the merge process.

1. If not already happened by: Create Issue for the new feature
2. If not already happened by Merge Request:Connect Issue and Branch
3. Merge the request into the **Dev** branch
4. Delete the source feature branch

#### Default closing pattern
To automatically close an issue after the corresponding merge request is closed, use the following keywords followed by the issue reference.

Available keywords:

- Close, Closes, Closed, Closing, close, closes, closed, closing
- Fix, Fixes, Fixed, Fixing, fix, fixes, fixed, fixing
- Resolve, Resolves, Resolved, Resolving, resolve, resolves, resolved, resolving
- Implement, Implements, Implemented, Implementing, implement, implements, implemented, implementing

Available issue reference formats:

- A local issue (`#123`).
- A cross-project issue (`group/project#123`).
- The full URL of an issue (`https://github.example.com/group/project/issues/123`).

e.g.

```
Fancy commit message

Fix #20, Fixes #21 and Closes group/otherproject#22.
This commit is also related to #17 and fixes #18, #19
and https://gitlab.example.com/group/otherproject/issues/23.
```

### Issues Workflow
For major changes, please open an issue first to discuss what you would like to change and connect the new feature branch with the issue. Use a separate branch for each feature and issue you work on.

### The overall flow is:

-   A Dev branch is created from Master
-   Feature branches are created from Dev
-   When a Feature is complete it is merged into the Dev branch
-   Bugfix branches are created from Dev
-   When bug fixed are done it is merged into the Dev branch
-   Only when a new Version Release is ready it is merged into Master
-   If an issue in Master is detected a Hotfix branch is created from Master 
-   When the Hotfix is complete it is merged to both Dev and Master
