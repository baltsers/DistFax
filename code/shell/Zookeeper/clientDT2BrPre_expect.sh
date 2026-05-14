#!/usr/bin/expect
set f [open [lindex $argv 0]]
set sentences [split [read $f] "\n"]
close $f


spawn ./zkClient_DT2BrPre.sh
#sleep 2
expect "WatchedEvent state:SyncConnected type:None path:null"
send "\r"
#sleep 1
expect "zk: localhost:2181(CONNECTED) 0"
send "create -e /zk-temp 123 \r"
#sleep 1
expect "zk: localhost:2181(CONNECTED)"
foreach sentence $sentences {
    send "$sentence \r"
    #sleep 1
	#expect "ij>"
    expect "zk: localhost:2181(CONNECTED)"
}

send "delete /zk-temp \r"
#sleep 1
expect "zk: localhost:2181(CONNECTED)"

send "close \r"
sleep 1
send "\r"
expect "zk: localhost:2181(CONNECTED)"

send "quit \r"
sleep 1

