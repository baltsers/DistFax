#!/usr/bin/expect
set f [open [lindex $argv 0]]
set sentences [split [read $f] "\n"]
close $f

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
