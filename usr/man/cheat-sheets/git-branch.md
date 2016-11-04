## Branch

    git branch --edit-description           # set branch description

#### rename branch

    git branch -m old new                   # rename branch locally
    git push origin :old                    # delete the old branch
    git push --set-upstream origin new      # push the new branch
