#### mysql

##### service

    mysql.server start
    mysql.server restart
    mysqladmin --user=root --password shutdown

##### info

    mysqladmin --user=root --password version
    mysqladmin --user=root --password status
    mysqladmin --user=root --password variables

##### commands

    mysql --user=root --password
    echo "show databases;" | mysql --user=root --password
