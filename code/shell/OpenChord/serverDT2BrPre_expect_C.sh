#!/usr/bin/expect
set f [open [lindex $argv 0]]
set sentences [split [read $f] "\n"]
close $f

set portlast [lindex $argv 1]]

set timeout 60
spawn ./serverDT2BrPre2BrPre.sh
expect -re "oc >"
set ports [exec sh -c {./RANDOMPORT.sh}]
#send "joinN -port 8081 -bootstrap 10.99.1.190:4242\n"
send "joinN -port $ports -bootstrap 10.99.1.190:4242\n"
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
