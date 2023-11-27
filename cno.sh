#!/bin/bash

#####################################################
#   Clone 'n Open                                   #
#   Desc: Clones and opens a repo in VS Code        #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 11/27/2023                        #
#####################################################




giturl=$1;
echo $giturl;

# get github or gitlab from url
if [[ $giturl == "https://"* ]]; then
  gitdomain=$(echo $giturl | sed 's/https:\/\///' | sed 's/\/.*//' | sed 's/\.com//');
elif [[ $giturl == "git@"* ]]; then
  gitdomain=$(echo $giturl | sed 's/git@//' | sed 's/:.*//' | sed 's/\.com//');
else
  echo "Git url not recognized.";
  exit 1;
fi

# take location from env variable
if [ -z "$MY_GIT_DIR" ]; then
  echo "No git directory set. Using default: $HOME/Documents/$gitdomain";
  if [ ! -d "$HOME/Documents/$gitdomain" ]; then
    mkdir -p $HOME/Documents/$gitdomain;
  fi
  gitdir=$HOME/Documents/$gitdomain;
else
  gitdir=$MY_GIT_DIR;
fi

cd $gitdir;

git clone $giturl;
# Get directory name from git url
dirname=$(echo $giturl | sed 's/.*\///' | sed 's/.git//');
code ./$dirname;