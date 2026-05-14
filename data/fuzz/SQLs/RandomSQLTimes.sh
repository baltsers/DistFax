sleep 1
for((i=1;i<=$1;i++)); 
do   
	./RandomSQL.sh  > SQL$i.txt
done  
