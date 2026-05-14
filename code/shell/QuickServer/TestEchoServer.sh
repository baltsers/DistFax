#!/bin/bash
# args = port ip maxClient clientJunkCount clientJunkSleepInSec
# exec java -cp ./../dist/QuickServer.jar:./dist/echoserver.jar echoserver.TestEchoServer 4123 127.0.0.1 1000 5 1
exec java -cp ./../dist/QuickServer.jar:./dist/echoserver.jar echoserver.TestEchoServer 4123 127.0.0.1 1000 100 180