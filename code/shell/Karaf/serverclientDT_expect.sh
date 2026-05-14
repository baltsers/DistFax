#!/usr/bin/expect
set f [open [lindex $argv 0]]
set sentences [split [read $f] "\n"]
close $f

spawn $ROOT/karaf/bin/startDT
sleep 1
spawn $ROOT/karaf/bin/clientDT -a 8101 -h localhost -u karaf -p karaf 
sleep 2
#expect "karaf@root>"

foreach sentence $sentences {
	#expect "karaf@root>"
    send "$sentence \r"
    sleep 2 
	#expect "karaf@root>"
}

#send "osgi:shutdown \r"
#expect "karaf@root>"
send "logout \r"

sleep 1
expect "$"
spawn $ROOT/karaf/bin/stopDT
sleep 1
