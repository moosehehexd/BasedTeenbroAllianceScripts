#!/bin/bash
# EXTREMELY basic spamming script
# Not intended for use with proxies. Run it by yourself or get multiple peoplt to run it.
# Thread ID should be specified like so: 22057
# Timeout is specified by "sleep" 60 -> 60 seconds
# Everything else explains itself.
while true; do curl -X POST -F 'message=Absolutely Based' -F 'boardUri=board' -F 'threadId=22057' https://lynxchanimageboard.xyz/replyThread.js;date ; sleep 60; done

