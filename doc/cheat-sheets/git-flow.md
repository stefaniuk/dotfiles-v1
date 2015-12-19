## Flow

#### develop

    git checkout -b feature master          # create new feature branch
    git commit -am "new feature"            # do some work and commit your changes
    git push --set-upstream origin feature  # makes it remotely available   
    git merge master                        # periodically merge from master

#### merge

    git checkout master                     # switch back to master
    git merge --no-ff feature               # and merge your changes
    git push origin master                  # push master

#### clean

    git branch -d feature                   # delete local feature branch
    git push origin :feature                # delete remote feature branch
    git fetch --prune                       # remove non-existing branches
