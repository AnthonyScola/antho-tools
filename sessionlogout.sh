#!/bin/bash

#####################################################
#   Application Name: Session Logout                #
#   Desc: This is a simple logout script for        #
#         logging out of your current session.      #
#         Sometimes the GUI doesn't do it right!    #
#                                                   #
#   By: Anthony Scola                               #
#   Last updated: 12/07/2023                        #
#####################################################

# Detect the desktop environment
DESKTOP_ENV=$(echo $XDG_CURRENT_DESKTOP | tr '[:upper:]' '[:lower:]')

case $DESKTOP_ENV in
  gnome)
    # GNOME, Unity
    gnome-session-quit --logout --no-prompt
    ;;
  kde)
    # KDE
    qdbus org.kde.ksmserver /KSMServer logout 0 0 0
    ;;
  xfce)
    # XFCE
    xfce4-session-logout --logout
    ;;
  lxde|lxqt)
    # LXDE, LXQT
    lxsession-logout
    ;;
  *)
    # Fallback: attempt to use 'logout' (may not work in all cases)
    logout
    ;;
esac
