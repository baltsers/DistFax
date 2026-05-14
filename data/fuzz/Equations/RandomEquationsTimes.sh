sleep 1
for((i=1;i<=$1;i++)); 
do   
	./RandomEquation.sh > Equation$i.txt
done  
