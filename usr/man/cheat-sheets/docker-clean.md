## Clean

    docker stop $(docker ps -a -q)

#### remove exited containers

    docker rm -v $(docker ps -a -q -f status=exited)

#### remove unwanted images

    docker rmi $(docker images -f "dangling=true" -q)
    docker rmi $(docker images | grep "^<none>" | awk '{ print $3 }')

#### remove all images

    docker rmi $(docker images -a | awk '{ print $3 }' | grep -v IMAGE)
