## Change Author

#### script

    git log --format='%an' | sort | uniq
    git filter-branch --force --commit-filter '
        if [ "$GIT_COMMITTER_NAME" = "daniel" ];
        then
                GIT_COMMITTER_NAME="Daniel Stefaniuk";
                GIT_AUTHOR_NAME="Daniel Stefaniuk";
                GIT_COMMITTER_EMAIL="daniel.stefaniuk@gmail.com";
                GIT_AUTHOR_EMAIL="daniel.stefaniuk@gmail.com";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
    git push --force origin
