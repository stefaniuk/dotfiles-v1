## Commands

#### diff

    git diff --ignore-space-at-eol          # ignore line endings
    git diff --ignore-all-space
    git diff --stat --cached                # list files to be pushed
    git diff --name-status feature..master  # compare two branches
    git diff --stat --color feature..master # compare two branches
    git diff feature..master                # compare two branches
    git diff feature master -- ./file

#### misc

    git credential-cache exit               # clear cached credentials

    git reset HEAD filename                 # unadd filename
    git reset --soft HEAD~1                 # undo last commit

    git clean -f -d --dry-run               # remove files
