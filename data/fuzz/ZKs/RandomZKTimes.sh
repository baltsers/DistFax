sleep 1
for((i=1;i<=$1;i++)); 
do   
	./RandomZKs.sh  > ZK$i.txt
done  
