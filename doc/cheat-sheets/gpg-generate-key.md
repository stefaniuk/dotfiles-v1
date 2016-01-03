## Generate Key

#### unattended

    $ cat >key.script <<EOF
        %echo Generating an OpenPGP key
        Key-Type: RSA
        Key-Length: 4096
        Subkey-Type: ELG
        Subkey-Length: 4096
        Name-Real: Daniel Stefaniuk
        Name-Email: daniel.stefaniuk@gmail.com
        Name-Comment: comment
        Expire-Date: 0
        Passphrase: passphrase
        %pubring daniel-stefaniuk.gpg-key.pub
        %secring daniel-stefaniuk.gpg-key.sec
        %commit
        %echo Done
    EOF
    $ gpg2 --batch --gen-key key.script
    $ rm key.script
