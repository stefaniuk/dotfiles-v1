#### ssh

##### keys

    ssh -i ~/.ssh/host.key username@host.com

##### port forwarding

    ssh -f -N -L 8888:127.0.0.1:3306 user@db.host.com
