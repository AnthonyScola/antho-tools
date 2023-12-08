#!/bin/bash

#####################################################
#   Application Name: USB SCP                       #
#   Desc: Appends the contents of an rsa.pub to     #
#         your authorized_keys locally.             #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 12/07/2023                        #
#####################################################

# Get the directory of the script
SCRIPT_DIR=$(dirname "$0")

# Path to the public key on your flash drive
PUB_KEY_PATH="$SCRIPT_DIR/id_rsa.pub"

# Exit if the public key file doesn't exist
if [ ! -f "$PUB_KEY_PATH" ]; then
    echo "The id_rsa.pub file is not present in the script directory."
    exit 1
fi

# Path to the authorized_keys file on your system
AUTHORIZED_KEYS_PATH="$HOME/.ssh/authorized_keys"

# Create the authorized_keys file if it doesn't exist
if [ ! -f "$AUTHORIZED_KEYS_PATH" ]; then
    touch $AUTHORIZED_KEYS_PATH
    echo "authorized_keys file created."
fi

# Append the public key to the authorized_keys file on your system
cat $PUB_KEY_PATH >> $AUTHORIZED_KEYS_PATH