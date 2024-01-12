#!/bin/bash

#########################################################
# This script will prepare prepare for shutdonw,
# notify all users, and shutdown the system with a
# delay
#
# Author: Ismet Handzic
#
# NOTE: $1 argument is passed by ACPID into this script
#########################################################

MESSAGE="Powerbutton has been pressed. System shutdown in 2 seconds"

echo "Shutdown script ACPI event: ${1}"
logger --priority local0.warning --tag POWER-BUTTON "Shutdown script ACPI event: ${1}"

logger --priority local0.warning --tag POWER-BUTTON "Adding to sys log and adding message to logged-in users ..."
logger --priority local0.warning --tag POWER-BUTTON "${MESSAGE}"
wall "${MESSAGE}"
echo "${MESSAGE}"

# logger --priority local0.warning --tag POWER-BUTTON "Showing desktop UI notification message ..."
# notify-send "System Shutting Down" "${MESSAGE}" --urgency critical --expire-time 2500

logger --priority local0.warning --tag POWER-BUTTON "Sleeping 2 seconds ..."
sleep 2

logger --priority local0.warning --tag POWER-BUTTON "Sending system shutdown command ..."
sync
sync
shutdown -h now
