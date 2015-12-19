## Clean

#### remove exited containers

    docker rm -v $(docker ps -a -q -f status=exited)

#### remove unwanted images

    docker rmi $(docker images -f "dangling=true" -q)

#### remove all images

    docker rmi $(docker images -a | awk '{ print $3 }' | grep -v IMAGE)
