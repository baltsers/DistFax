source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/DiverInstrumented:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/libs/distDIVER.jar"
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} XSocketServer
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds
