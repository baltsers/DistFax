sleep 1
for((i=1;i<=$1;i++)); 
do   
	./RandomChords.sh  > Chord$i.txt
done  
