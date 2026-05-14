#!/usr/bin/expect
set f [open [lindex $argv 0]]
set sentences [split [read $f] "\n"]
close $f


spawn ./clientDT2BrPre.sh
sleep 1
expect "ij>"
send "connect 'jdbc:derby:firstdb;create=true'; \r"
sleep 1
expect "ij>"
send "DROP TABLE firsttable; \r"
sleep 1
expect "ij>"
send "create table firsttable(id int primary key, name varchar(255)); \r"
sleep 1
expect "ij>"
send "insert into firsttable values(1,'First');\r"
sleep 1

foreach sentence $sentences {
	#expect "ij>"
    send "$sentence \r"
    sleep 3
	#expect "ij>"
}

expect "ij>"
send "exit; \r"

