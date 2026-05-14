#!/usr/bin/expect
set f [open [lindex $argv 0]]
set sentences [split [read $f] "\n"]
close $f

set timeout 60
spawn ./serverDT2BrPre.sh
expect -re "oc >"
send "joinN \r"
sleep 6 


foreach sentence $sentences {
	#expect "oc >"
    send "$sentence \r"
    sleep 1
	expect -re "oc >"
}

sleep 18
send \003
expect eof
