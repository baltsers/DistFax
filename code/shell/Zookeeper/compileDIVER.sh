#!/bin/bash
source ./zs_global.sh
MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:/opt/jdk1.8.0_101/lib/tools.jar:$ROOT/libs/DUA1.jar:$ROOT/libs/mcia.jar::$ROOT/libs/soot-trunk5.jar:$ROOT/zookeeper/build/zookeeper-3.4.11.jar:$ROOT/zookeeper/build/classes:$ROOT/zookeeper"
echo $MAINCP
/opt/jdk1.8.0_101/bin/javac -Xlint:unchecked -cp ${MAINCP} AllTestsSelect.java

