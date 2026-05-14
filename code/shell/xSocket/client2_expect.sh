#!/usr/bin/expect
# set timeout 60
spawn ./client2.sh
sleep 1
set filename [lindex $argv 0] 
spawn cat $filename
#set "\r"
#set "q \r"
#expect eof
