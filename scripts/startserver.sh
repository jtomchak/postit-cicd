#!bin/bash
docker pull jtomchak/postit-cicd:latest

if [ "$(docker ps -q -f name=cicd)" ]; then
  docker kill cicd
fi
    # run your container
docker run --rm -ti  -d -p 0.0.0.0:80:4000 \
--name cicd --group-add $(stat -c '%g' /var/run/docker.sock) \
-v /var/run/docker.sock:/var/run/docker.sock \
-e SECRET_KEY_BASE="Pg0zPZDmsL/YjrxDZKvDvuLbHURlrdPgiOyJWeIlyA+PEDudzegaOThUvoFIUTyD"  \
-v /home/build_user/keyfile.json:/home/keyfile.json \
jtomchak/postit-cicd:latest