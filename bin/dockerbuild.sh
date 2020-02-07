#!/usr/bin/env bash
# dock run the actual build of the gatsby site. 

echo "pulling latest image..."
docker pull jtomchak/postitci:latest

echo $1

echo "execute docker run postitci"
docker run --rm \
-e GOOGLE_ACCOUNT_KEY="$1" \
-e GOOGLE_PROJECT_ID=post-it-services \
-e USERNAME="$2" \
jtomchak/postitci:latest
