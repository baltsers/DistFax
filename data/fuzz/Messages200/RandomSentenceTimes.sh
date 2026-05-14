sleep 1
for((i=1;i<=$1;i++)); 
do   
	./RandomSentence.sh > Message$i.txt
done  