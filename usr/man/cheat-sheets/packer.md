## Configuration

    export ATLAS_TOKEN=TOKEN

## Commands

#### build

    git clone https://github.com/boxcutter/ubuntu.git
    cd ubuntu
    packer build -only=virtualbox-iso -var-file=ubuntu1404.json ubuntu.json

#### upload

    curl "https://atlas.hashicorp.com/api/v1/box/USERNAME/BOX_NAME/version/VERSION/provider/PROVIDER_NAME/upload?access_token=$ATLAS_TOKEN"

    curl -X PUT --upload-file foo.box --progress-bar --verbose https://binstore.hashicorp.com/UUID
