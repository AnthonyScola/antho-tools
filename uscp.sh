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

# Path to the authorized_keys file on your system
AUTHORIZED_KEYS_PATH="$HOME/.ssh/authorized_keys"

# Append the public key to the authorized_keys file on your system
cat $PUB_KEY_PATH >> $AUTHORIZED_KEYS_PATH