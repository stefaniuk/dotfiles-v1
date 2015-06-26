#### git

##### flow

    git checkout -b feature master          # create new feature branch
    git commit -am "new feature"            # do some work and commit your changes
    git push --set-upstream origin feature  # makes it remotely available

    git merge master                        # periodically merge from master

    git checkout master                 # switch back to master
    git merge --no-ff feature           # and merge your changes
    git push origin master              # push master

    git push origin :feature            # delete remote feature branch
    git branch -d feature               # delete local feature branch

    git fetch --prune                   # remove non-existing branches

    git checkout stable                 # switch back to stable
    git merge \
        --squash \
        --strategy=recursive \
        --strategy-option=theirs \
        --log \
        master

    git merge \
        --no-ff \
        --strategy=recursive \
        --strategy-option=theirs \
        --log --edit -m "Hotfix: [comment]" \
        hotfix/hotfix-[name]

    git merge --abort                   # only if there are conflicts

##### selective commit

    git add --intent-to-add filename    # -N
    git add --patch filename            # -p
    git diff --staged
    git commit -m "message"

##### rename branch

    git branch -m old new               # rename branch locally
    git push origin :old                # delete the old branch
    git push --set-upstream origin new  # push the new branch

##### create empty branch

    git checkout --orphan new           # new branch without any commit
    git rm -rf .
    git add .
    git commit -m "initial commit"
    git push --set-upstream origin new  # push the new branch

##### create tag

    git tag -a v1.2.3 -m "v1.2.3"       # create an annotated tag
    git push origin v1.2.3              # push tag
    git push origin --tags              # push all tags

##### other

    git credential-cache exit               # clear cached credentials
    git diff --ignore-space-at-eol          # ignore line endings
    git diff --stat --cached                # list files to be pushed
    git diff --name-status stable..master   # compare two branches
    git diff --stat --color stable..master  # compare two branches
    git diff stable..master                 # compare two branches
    git diff stable master -- file
    git diff -w (--ignore-all-space)
    git reset HEAD filename                 # unadd filename
    git clean -f -d --dry-run               # remove files after switching branch
    git reset --soft HEAD~1                 # undo last commit
    git branch --edit-description           # set branch description
