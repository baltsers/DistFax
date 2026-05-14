source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/DiverInstrumented:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/libs/distDIVER.jar"
java -cp ${MAINCP} XSocketClient
