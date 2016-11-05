#!/bin/bash

if [ $# -lt 1 ]; then
	echo 'usage: plugin-tag 1.2.3'
	exit
fi

TAG_NAME=$1
DEPLOYER=$(pwd)'/plugin-deploy.sh';

git tag $TAG_NAME
git push
git push --tags

sh $DEPLOYER "tagging version $TAG_NAME" tags/$TAG_NAME