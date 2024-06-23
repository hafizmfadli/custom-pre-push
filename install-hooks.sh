#!/bin/sh

# read input project path from 
dir="$1"

if [ "$dir" = "" ]
then
    echo "project directory must be specified"
    exit 1
fi

if [ ! -d "$dir/.git/hooks" ]; then
    echo "directory $dir/.git/hooks does not exist"
    exit 1
fi

cp ./pre-push.sh $dir/.git/hooks/pre-push

# TODO : if you want to add new githook
# Just add your new githook here to copy to your repository
# Example :
# cp ./pre-push.sh $dir/.git/hooks/prepare-commit-msg
# cp ./pre-commit.sh $dir/.git/hooks/pre-commit


chmod 755 $dir/.git/hooks/pre-push

# TODO : afer you copy your new githook
# Just add executable permission to your new githook
# Example :
# chmod 755 $dir/.git/hooks/prepare-commit-msg
# chmod 755 $dir/.git/hooks/pre-commit

