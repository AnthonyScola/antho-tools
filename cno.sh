#!/bin/bash
#####################################################
#   Clone 'n Open                                   #
#   Desc: Clones and opens a repo in VS Code        #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 11/28/2023                        #
#####################################################
giturl=$1;
echo $giturl;

case "$giturl" in
"https://"*)
  gitdomain=$(echo $giturl | awk -F/ '{print $3}' | awk -F. '{print $1}')
  ;;
"git@"*)
  gitdomain=$(echo $giturl | awk -F@ '{print $2}' | awk -F: '{print $1}' | awk -F. '{print $1}')
  ;;
*)
  echo "Git url not recognized."
  exit 1
  ;;
esac

# take location from env variable or use default
gitdir=${MY_GIT_DIR:-$HOME/$gitdomain}

[ -d "$gitdir" ] && echo "Directory $gitdir already exists." || {
    read -p "Directory $gitdir does not exist. Do you want to create it? (y/n) " confirm
    [ "$confirm" = "y" ] && mkdir -p $gitdir && echo "Directory $gitdir created." || echo "Directory not created."
}

cd $gitdir;

git clone $giturl;
# Get directory name from git url
dirname=$(echo $giturl | sed 's/.*\///' | sed 's/.git//');
code ./$dirname;