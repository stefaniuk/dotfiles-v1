#### ssh

    ssh -i ~/.ssh/host.key \
        username@host.com           # connect

    ssh -f -N \
        -L 8888:127.0.0.1:3306 \
        user@db.host.com            # port forwarding

    ssh-add -l                      # list keys
    ssh-add ~/.ssh/key              # add key
    ssh-add -D                      # delete all cached keys
