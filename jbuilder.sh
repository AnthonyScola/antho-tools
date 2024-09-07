#!/bin/bash

#####################################################
#   Application Name: Jbuilder                      #
#   Desc: Bulds and runs your java project.         #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 09/06/2024                        #
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

# Extract project name and version from pom.xml using xmlstarlet
name=$(xmlstarlet sel -t -v '//artifactId' pom.xml)
version=$(xmlstarlet sel -t -v '//version' pom.xml)

# Checks maven-compiler-plugin configuration for preview features
if grep -q '\-\-enable-preview' pom.xml; then
  PREVIEW_FLAG="--enable-preview"
  echo "[INFO] Preview settings found, enabling preview mode for build"
else
  PREVIEW_FLAG=""
fi

# Build and run the java project
if mvn clean install -Dmaven.test.skip=true; then
  java $PREVIEW_FLAG -jar "./target/$name-$version-exec.jar"
else
  echo "Build failed. Not running the application."
fi

# Change back to original directory
popd >/dev/null
