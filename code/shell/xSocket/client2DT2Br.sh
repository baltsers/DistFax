source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/DT2BrPre:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint/bin"
java -cp ${MAINCP} XSocketClient2
