#!/usr/bin/env bash
##################################################################################
# Bash script for merging two datasets with plink                                #
# it is assumed :
# - files have the same snp name!
# - scripts: (exist and are place in scripts folder)
#	rmsnp.py / snplist.py
##################################################################################

#VARIABLES (3)
#file 1 to merge (binary!) - no ext!
F1=$1
#file 2 to merge (also binary !) - no ext!
F2=$2
# merged file name (no extension!!)
MERG=$3
#scripts dir
DIR=$4

#plink version (module to load)
PLINK=PLINK/1.9b

echo "variables:"
echo "	Using populations file 1: $F1"
echo "	Using populations file 2: $F2"
echo "	Using merged file name: $MERG"
echo "	Using scripts directory: $DIR"
echo "	Using plink version: $PLINK"

#load plink
module load $PLINK


##1. try merge
plink --bfile $F1 --bmerge $F2 --allow-no-sex --make-bed --out $MERG

#check for missing snp
MISSF=${MERG}-merge.missnp

##1.2 check if there is missing snp (triall)
if [ -f "$MISSF" ]; then
	echo "Removing triallellic or other problematic variants...";
		#init file with files to merge list
	echo $F1 > list_tomerge1 ; echo $F2 >> list_tomerge1 ;
		##filter out triall var  
	python ${DIR}/rmsnp.py list_tomerge1 $MISSF; 
		# merge files
	echo "Update files to work... "; F1=${F1}_rmsnp ; F2=${F2}_rmsnp;
	plink --bfile $F1 --bmerge $F2 --allow-no-sex --make-bed --out $MERG
fi

## 2. list of snp from each dataset
python ${DIR}/snplist.py  ${F1}.bim ${F2}.bim

## 3.common snp from two lists
comm -12 <(sort ${F1}_snplist) <(sort ${F2}_snplist) > commsnp_LIST

## 4. extract common snp from merged dataset
plink --bfile $MERG --extract commsnp_LIST --make-bed --out ${MERG}_comsnp

## 5. apply ld
plink --bfile ${MERG}_comsnp --indep-pairwise 200 25 0.5 --out ${MERG}_comsnp_ld
plink --bfile ${MERG}_comsnp --extract ${MERG}_comsnp_ld.prune.in --make-bed --out ${MERG}_comsnp_ld
