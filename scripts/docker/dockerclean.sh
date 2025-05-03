#!/bin/bash

docker stop $(docker ps -aq) 2>/dev/null

docker rm $(docker ps -aq) 2>/dev/null

docker rmi $(docker images -q) 2>/dev/null

docker volume rm $(docker volume ls -q) 2>/dev/null

docker network rm $(docker network ls -q) 2>/dev/null

docker image prune -f 2>/dev/null

docker system prune

echo "Docker environment cleaned."
