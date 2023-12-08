#!/bin/bash

#####################################################
#   Application Name: USB Secure Copy               #
#   Desc: Appends the contents of an rsa.pub to     #
#         your authorized_keys locally.             #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 12/07/2023                        #
#####################################################

# Get the directory of the script
SCRIPT_DIR=$(dirname "$0")

# Check if the first command line argument is --help or -h
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "USB Secure Copy (uscp.sh)"
    echo "-------------------------"
    echo "Description: This script appends the contents of an rsa.pub file to your local authorized_keys."
    echo "Usage: ./uscp.sh [public_key_path]"
    echo "Options:"
    echo "  -h, --help    Show this help message and exit."
    echo "Arguments:"
    echo "  public_key_path    Optional. Path to the public key. If not provided, the default path ($SCRIPT_DIR/id_rsa.pub) will be used."
    exit 0
fi

# Path to the public key on your flash drive
# Use the first command line argument as the public key path, if provided
PUB_KEY_PATH=${1:-"$SCRIPT_DIR/id_rsa.pub"}

# Exit if the public key file doesn't exist
if [ ! -f "$PUB_KEY_PATH" ]; then
    echo "id_rsa.pub not found! Exiting.. "
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