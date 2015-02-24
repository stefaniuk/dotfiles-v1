#### mysql

##### service

    mysql.server {start|stop|restart|status}

##### info

    mysqladmin --user=root --password version
    mysqladmin --user=root --password status
    mysqladmin --user=root --password variables

##### commands

    mysqladmin -u root password "root"                      # set password
    mysql --user=root --password                            # client
    echo "show databases;" | mysql --user=root --password   # SQL command
