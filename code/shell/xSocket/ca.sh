#!/bin/bash
source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/xSocket.jar"
javac -cp ${MAINCP} *.java -d `pwd`/bin
 



