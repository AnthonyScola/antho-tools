#!/bin/bash

#####################################################
#   Application Name: Jbuilder                      #
#   Desc: Bulds and runs your java project.         #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 12/02/2023                        #
#####################################################

# Initialize killports flag as false
killports=false

# Parse command-line arguments
while (( "$#" )); do
  case "$1" in
    --killports)
      killports=true
      shift
      ;;
    *)
      echo "Error: Invalid argument"
      exit 1
      ;;
  esac
done

# Kill Web ports if --killports is passed
if [ $killports = true ]; then
  pkill -f ':8080'
  pkill -f ':9001'
fi

# Change to project directory
pushd "./$(basename `pwd`)" >/dev/null

# Extract project name and version from pom.xml
name=$(xmlstarlet sel -t -v '//artifactId' pom.xml)
version=$(xmlstarlet sel -t -v '//version' pom.xml)

# Build and run the java project
if mvn clean install -Dmaven.test.skip=true; then
  java -jar "./target/$name-$version-exec.jar"
else
  echo "Build failed. Not running the application."
fi

# Change back to original directory
popd >/dev/null