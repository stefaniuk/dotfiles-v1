## Commands

    $ ansible group -i inventory -m setup
    $ ansible hostname -m setup -a 'filter=ansible_*_mb'
