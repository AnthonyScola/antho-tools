#!/bin/bash

#####################################################
#   Application Name: USB SCP                       #
#   Desc: Appends the contents of an rsa.pub to     #
#         your authorized_keys locally.             #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 12/02/2023                        #
#####################################################

cat id_rsa.pub >> ~/.ssh/authorized_keys # Uh I couldn't get this to work...