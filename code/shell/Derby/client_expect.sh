#!/usr/bin/expect
set timeout 60

spawn ./client.sh
sleep 1
expect "ij>"
send "connect 'jdbc:derby:firstdb'; \r"
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
expect "ij>"
send "exit; \r"

