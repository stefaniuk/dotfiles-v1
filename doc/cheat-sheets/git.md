## Commands

#### flow

    git checkout -b feature master          # create new feature branch
    git commit -am "new feature"            # do some work and commit your changes
    git push --set-upstream origin feature  # makes it remotely available
    git merge master                        # periodically merge from master
    git checkout master                     # switch back to master
    git merge --no-ff feature               # and merge your changes
    git push origin master                  # push master
    git push origin :feature                # delete remote feature branch
    git branch -d feature                   # delete local feature branch
    git fetch --prune                       # remove non-existing branches

#### merge

    git checkout master
    git merge \
        --squash|--ff|--no-ff \
        --strategy=recursive \
        --strategy-option=theirs|ours \
        --log=1000 --edit \
        feature
    git merge --abort

#### selective commit

    git add --intent-to-add filename
    git add --patch filename
    git diff --staged
    git commit -m "message"

#### rename branch

    git branch -m old new                   # rename branch locally
    git push origin :old                    # delete the old branch
    git push --set-upstream origin new      # push the new branch

#### create tag

    git tag -a v1.2.3 -m "v1.2.3"           # create an annotated tag
    git push origin v1.2.3                  # push tag
    git push origin --tags                  # push all tags

#### other

    git credential-cache exit               # clear cached credentials

    git diff --ignore-space-at-eol          # ignore line endings
    git diff --ignore-all-space
    git diff --stat --cached                # list files to be pushed
    git diff --name-status feature..master  # compare two branches
    git diff --stat --color feature..master # compare two branches
    git diff feature..master                # compare two branches
    git diff feature master -- ./file

    git reset HEAD filename                 # unadd filename
    git reset --soft HEAD~1                 # undo last commit
    git clean -f -d --dry-run               # remove files after switching branch
    git branch --edit-description           # set branch description
