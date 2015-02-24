#### git

##### flow

    git checkout -b feature master      # create new feature branch
    git commit -am "new feature"        # do some work and commit your changes
    git push origin feature             # makes it remotely available

    git merge master                    # periodically merge from master

    git checkout master                 # switch back to master
    git merge --no-ff feature           # and merge your changes
    git push origin master              # push master

    git push origin :feature            # delete remote feature branch
    git branch -d feature               # delete local feature branch

    git fetch --prune                   # remove non-existing branches

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

    git reset HEAD filename             # unadd filename
