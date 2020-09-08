#!/bin/bash
#FOR EACH DIR
#using admixture
#idea: use k from 2 to 12, 10 times diff
FILE=$1
seed=$2
echo "Using bim file: $FILE"
echo "Using seed number: $seed"
#Use ADMIXTURE’s cross-validation procedure. A good value of K will exhibit a low cross-validation error compared to other K values. 
#Cross-validation is enabled by simply adding the --cv flag to the ADMIXTURE command line. 
#using --cv=10. The cross-validation error is reported in the output. For example,
MOD="module load admixture/1.3.0"

for K in 2 3 4 5 6 7 8 9 10 11 12; \
do sbatch --job-name=admxt${K}_${seed} --nodes=1 --ntasks-per-node=1 --output=log${K}_${seed}.out --wrap="$MOD; admixture -s $seed --cv $FILE $K "; 
done
#view the CV errors:
#% grep -h CV log*.out
#CV error (K=1): 0.55248
#CV error (K=2): 0.48190
#CV error (K=3): 0.47835
#CV error (K=4): 0.48236
#CV error (K=5): 0.48985
#where the number in parentheses is the standard error of the cross-validation error estimate. We can easily plot these values for comparison,  1, which makes it fairly clear that K = 3 is a sensible modeling choice.




##############


#pong

