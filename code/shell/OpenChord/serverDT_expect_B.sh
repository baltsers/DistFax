#!/usr/bin/expect
set f [open [lindex $argv 0]]
set sentences [split [read $f] "\n"]
close $f

set timeout 60
spawn ./serverDT.sh
expect -re "oc >"
send "joinN -port 8080 -bootstrap 10.99.1.190:4242\n"
sleep 1
expect -re "oc >"
send "insertN -key test -value test \r"
sleep 1
expect -re "oc >"

foreach sentence $sentences {
	#expect "oc >"
    send "$sentence \r"
    sleep 1
	expect -re "oc >"
}

send "exit \r"
sleep 1
expect -re "Do you really want to shutdown?"

send "yes \r"
send "\r"
#sleep 1
#expect -re "Shutting down."
sleep 3
send \003
expect eof
