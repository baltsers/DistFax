source ./xs_global.sh
MAINCP=".:$ROOT/fuzz/kelinci/examples/xSocket/xSocket.jar:$ROOT/fuzz/kelinci/examples/xSocket/bin"
java -cp ${MAINCP} XSocketClient2
