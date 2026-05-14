#!/usr/bin/expect
proc slurp {file} {
    set fh [open $file r]
    set ret [read $fh]
    close $fh
    return $ret
}

starttime=`date +%s%N | cut -b1-13`

spawn ./client.sh
sleep 1
set sentence [slurp [lindex $argv 0]]
puts "sentence: $sentence"
send "$sentence \r"
send "q \r"
expect eof

stoptime=`date +%s%N | cut -b1-13`
echo "Netty Client Sending " `expr $stoptime - $starttime` milliseconds