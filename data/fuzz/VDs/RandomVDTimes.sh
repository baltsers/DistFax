sleep 1
for((i=1;i<=$1;i++)); 
do   
	./RandomVDs.sh  > VD$i.txt
done  
