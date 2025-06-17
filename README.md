# enforce-conventional-commits

## References

[Conventional Commits Website](https://www.conventionalcommits.org/en/v1.0.0-beta.2/)

## Prerequisites

- bash
- git

## Global Installation

1. In a terminal, navigate to this local repository's directory.
1. Run:

```
installGlobally.sh
```

From now on, every time you run `git init`, the `commit-msg` hook script will be
added to the new repository's git hooks (i.e. `.git/hooks`)

## Local Installation

1. In a terminal, navigate to the directory of the repository you want to
   install this hook in.
1. Run:

```
<enforce-conventional-commits-path>/installThisRepository.sh
```

From now on, every time you run `git commit`, the `commit-msg` hook script will
be run and it will enforce conventional commits.
