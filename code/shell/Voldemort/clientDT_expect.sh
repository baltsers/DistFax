#!/usr/bin/expect
set f [open [lindex $argv 0]]
set sentences [split [read $f] "\n"]
close $f


spawn ./vdClientShell_DT.sh
sleep 1
send "\r"
expect "> "
send "put 'hello' 'world' \r"
#sleep 1
expect "> "
foreach sentence $sentences {
	#expect "ij>"
    send "$sentence \r"
    #sleep 1
	expect "> "
}

send "delete 'hello2' \r"
#sleep 1
expect "> "

send "delete 'hello' \r"
sleep 1
expect "> "

send "exit \r"
sleep 1
#expect "bye."

