#!/usr/bin/expect
proc slurp {file} {
    set fh [open $file r]
    set ret [read $fh]
    close $fh
    return $ret
}


spawn ./clientDT.sh
sleep 1
set sentence [slurp [lindex $argv 0]]
puts "sentence: $sentence"
send "$sentence \r"
send "q \r"
expect eof

