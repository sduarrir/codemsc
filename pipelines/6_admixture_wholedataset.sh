#!/bin/bash
#FOR EACH DIR
bash admixture.sh
#view the CV errors:
grep -h CV log*.out
#CV error (K=1): 0.55248
#CV error (K=2): 0.48190
#CV error (K=3): 0.47835
#CV error (K=4): 0.48236
#CV error (K=5): 0.48985
#where the number in parentheses is the standard error of the cross-validation error estimate. We can easily plot these values for comparison,  1, which makes it fairly clear that K = 3 is a sensible modeling choice.

#######################################################PONG####################################################################################
 ### 1. WHOLE DATASET
#get order of pops (each individual)
cat mergeLAZ_FAGMER_PJL_comsnp_ld.fam | awk '{print $1}' > popind_lazmerpjl
#run pong: filemap (names all of the files it needs) pop orded (oder of the pops in the admixture) popinf, las step
#WITH PALLETE

pong -m filemap_lazmerpjl3 -n poporder_lazmerpjl_group -i popind_lazmerpjl -l paletapong.txt




