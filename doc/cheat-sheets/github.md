## Commands

#### maintain fork

    $ git clone https://github.com/YOUR-USERNAME/YOUR-FORK
    $ git remote -v
    $ git remote add upstream https://github.com/ORG/REPO.git
    $ git checkout upstream/master
    $ git branch --set-upstream-to=remotes/upstream/master upstream/master
    $ git fetch upstream
    $ git checkout master
    $ git rebase upstream/master
    $ git branch -av

#### feature branch

    $ git checkout -b my-feature master
    $ git push -f origin master
