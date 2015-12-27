## Commands

#### update fork

    $ git clone https://github.com/YOUR-USERNAME/YOUR-FORK
    $ git remote -v
    $ git remote add upstream https://github.com/ORG/REPO.git
    $ git fetch upstream
    $ git checkout master
    $ git rebase upstream/master

#### feature branch

    $ git checkout -b my-feature master
    $ git push -f origin master
