#!/bin/bash

##############################################################################
# Fail2Ban slack notification action script
#
# Ismet Handzic 12/25/2023
##############################################################################

# Slack webhook URL
# More info: https://api.slack.com/messaging/webhooks
WEBHOOK_URL="https://hooks.slack.com/services/T00000000/B00000000/MISSING"

# Slack message
MESSAGE="Fail2Ban: $1"

# Post to Slack
curl -X POST --data-urlencode "payload={\"text\": \"$MESSAGE\"}" $WEBHOOK_URL
