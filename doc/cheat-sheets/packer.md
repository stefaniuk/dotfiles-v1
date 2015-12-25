## Configuration

    export ATLAS_TOKEN=TOKEN

## Commands

    git clone https://github.com/boxcutter/ubuntu.git
    cd ubuntu
    packer build -only=virtualbox-iso -var-file=ubuntu1504.json ubuntu.json

    packer push -name stefaniuk/example template.json
