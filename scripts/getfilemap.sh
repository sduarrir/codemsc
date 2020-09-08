#!/bin/bash

### creates a file with all outputs of admixture, needed later on to run pong


##VARIABLES
FILE=$1 #file extension!
OUT=$2 #file
echo "Using file extension: $FILE"
echo "Creating new file: $OUT"
> $OUT
echo "Printing $OUT content..."

for I in  1 2 3 4 5 6 7 8 9 10;
do
echo $I;
SEED=`ls -1 | grep seed${I}_*`;
	for J in  2 3 4 5 6 7 8 9 10 11 12;
	do  echo -e "k${J}r${I}\t${J}\t${SEED}/${FILE}.${J}.Q"	>> $OUT
	done
done

echo "Done!!"

