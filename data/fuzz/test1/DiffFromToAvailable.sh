ROOT=/home/username
input="./diff0Available.txt"

while read -r i
do  
  if [ "$i" -ge "$1" ] && [  "$i" -le "$2" ] 
  then 
    cd /home/username/XNIO/test2
	cat /home/username/XNIO/test2/clientlog/$i/*.FL > /home/username/XNIO/test2/clientlog/$i/FL.txt
	file1=/home/username/XNIO/test2/clientlog/$i/FL.txt
	echo $file1
	echo -e "\n"	  
	for((j=1;j<=$2;j++)); 
	do
	if [ $i -gt $j ];
    then
		#cd /home/username/XNIO/test2
		#cat /home/username/XNIO/test2/clientlog/$i/*.FL > /home/username/XNIO/test2/clientlog/$i/FL.txt
		#file1=/home/username/XNIO/test2/clientlog/$i/FL.txt
		#echo $file1
		#echo -e "\n"		
		cat /home/username/XNIO/test2/clientlog/$j/*.FL > /home/username/XNIO/test2/clientlog/$j/FL.txt
        find /home/username/XNIO/test2/clientlog/$j/*.* -size 0 -delete
        if [ -f /home/username/XNIO/test2/clientlog/$j/FL.txt ];
        then    
			file2=/home/username/XNIO/test2/clientlog/$j/FL.txt
			#echo $file2
			#echo -e "\n"
			diff $file1 $file2 > /home/username/XNIO/test2/diff/diffClient_${i}_${j}.txt
			echo /home/username/XNIO/test2/diff/diffClient_${i}_${j}.txt
			#find /home/username/XNIO/test2/diff/diffClient_*.txt -size +1 -delete
		fi
    fi
    done  
    # find /home/username/XNIO/test2/diff/diffClient_*.txt -size +1 -delete	
  fi

  if [ $i -gt $2 ];
  then
    break
  fi

done < "$input"
find /home/username/XNIO/test2/diff/diffClient_*.txt -size 0 > /home/username/XNIO/test2/diff0/diff0.txt


