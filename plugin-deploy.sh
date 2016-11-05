#!/bin/bash

# args
MSG=${1-'deploy from git'}
BRANCH=${2-'trunk'}

# paths
SRC_DIR=$(git rev-parse --show-toplevel)
DIR_NAME=$(basename $SRC_DIR)
DEST_DIR=~/Desktop/my-plugins/svn/$DIR_NAME/$BRANCH
SVN_USERNAME=svn_username_here #your WordPress.org svn user

# make sure we're deploying from the right dir
if [ ! -d "$SRC_DIR/.git" ]; then
	echo "$SRC_DIR doesn't seem to be a git repository"
	exit
fi

# make sure the destination dir exists
svn mkdir $DEST_DIR 2> /dev/null
svn add $DEST_DIR 2> /dev/null

# delete everything except .svn dirs
for file in $(find $DEST_DIR/* -not -path "*.svn*")
do
	rm $file 2>/dev/null
done

# copy everything over from git, except hidden files (except .htaccess)
rsync -r  --exclude='*.git*' --include='*.htaccess*'  $SRC_DIR/ $DEST_DIR


cd $DEST_DIR

# check .svnignore
for file in $(cat "$SRC_DIR/.svnignore" 2>/dev/null)
do
	rm $file -rf
done

# check .distignore
for file in $(cat "$SRC_DIR/.distignore" 2>/dev/null)
do
        rm -rf $file
done


# svn addremove
svn stat | grep '^\?' | awk '{print $2}' | xargs svn add > /dev/null 2>&1
svn stat | grep '^\!' | awk '{print $2}' | xargs svn rm  > /dev/null 2>&1

svn stat

svn ci -m "$MSG" --username $SVN_USERNAME