## Desktop

#### format

    [Desktop Entry]
    Version=1.0
    Name=Application Name
    Type=Application
    Exec=/home/daniel/applications/name/start.sh
    Icon=/home/daniel/applications/name/icon.png
    Terminal=false
    Categories=Utility;

#### install

    file=~/new-app-name.desktop
    cp -f ~/doc/templates/Application.desktop $file
    subl $file
    desktop-file-validate $file
    sudo desktop-file-install $file
    rm $file
