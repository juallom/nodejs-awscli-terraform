```shell
docker pull ghcr.io/juallom/nodejs-awscli-terraform:latest
docker tag ghcr.io/juallom/nodejs-awscli-terraform:latest build-image
docker run -it -v ${PWD}/target:/workspace --rm --name builder build-image bash
```

# Delete all containers
```shell
docker rm -vf $(docker ps -aq)
```

# Delete all images
```shell
docker rmi -f $(docker images -aq)
```
