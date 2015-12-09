#### apt

##### search / info

    dpkg --get-selections | grep -v deinstall   # list installed packages
    apt-cache pkgnames                          # list all packages
    apt-cache search <term>                     # search packages
    apt-cache show <package>                    # show package details
    dpkg -L <package>                           # list files in package
    dpkg -c <deb>                               # list files in deb file
    apt-file search <file>                      # search file in packages

##### update / upgrade / install

    apt-get update
    apt-get upgrade
    apt-get dist-upgrade
    apt-get --only-upgrade install <package>
    apt-get --yes --force-yes --ignore-missing --no-install-recommends install <package>

##### build / compile

    apt-get build-dep <package>                 # install build dependencies
    apt-get source --compile <package>          # build from source

##### enable / disable

    dpkg-reconfigure <package>
    echo "<package> hold" | dpkg --set-selections
    echo "<package> install" | dpkg --set-selections

##### configure

    add-apt-repository <repository>
