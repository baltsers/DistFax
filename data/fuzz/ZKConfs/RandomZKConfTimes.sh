sleep 1
for((i=1;i<=$1;i++)); 
do   
	./RandomZKConfs.sh  > ZKConf$i.txt
done  
