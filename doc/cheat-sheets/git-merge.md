## Merge

    git checkout master

    git merge \
        --squash|--ff|--no-ff \
        --strategy=recursive \
        --strategy-option=theirs|ours \
        --log=1000 --edit \
        feature

    git merge --abort
