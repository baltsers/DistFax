source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/DT2BrPre:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} XSocketClient3 $1
stoptime=`date +%s%N | cut -b1-13`
echo "XSocketClient3 time:" `expr $stoptime - $starttime` milliseconds
