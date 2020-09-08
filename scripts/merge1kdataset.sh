#VARIABLES (3)
#file with the populations
FILE=$1
#extension
EXT=$2
#snp list file
SNPS=$3
#scripts dir
DIR=$4

echo "variables:"
echo "Using populations file: $FILE"
echo "Using extension: $EXT"
echo "Using snp list file: $SNPS"
echo "Using scripts directory: $DIR"



#load plink
module load PLINK/1.9b  
####################Get PUNJABI SAMPLES##############
##1. FILTER FOR pnj
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr1 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr1_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr2 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr2_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr3 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr3_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr4 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr4_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr5 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr5_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr6 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr6_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr7 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr7_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr8 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr8_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr9 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr9_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr10 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr10_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr11 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr11_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr12 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr12_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr13 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr13_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr14 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr14_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr15 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr15_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr16 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr16_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr17 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr17_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr18 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr18_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr19 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr19_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr20 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr20_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr21 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr21_${EXT}
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr22 --keep-fam $FILE --make-bed --out 1000genomes_phase3_fromvcf_chr22_${EXT}

## 2. rename snp
#init file
> chrlist
#file with chromosomes
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22; \
	do echo 1000genomes_phase3_fromvcf_chr${i}_${EXT} >> chrlist ;
done
#rename                                                             
python ${DIR}/ids.py chrlist 

## 3. filter snp for each chr
#init file
> chrlist_tofiltersnp
#file with chromosomes
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22; \
	do echo 1000genomes_phase3_fromvcf_chr${i}_${EXT}_snpname >> chrlist_tofiltersnp ;
done
#filter
python ${DIR}/filtersnp.py chrlist_tofiltersnp $SNPS

##4.  merge all files
#init file
> chrlist_tomerge1
#file with chr list
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22; \
do echo 1000genomes_phase3_fromvcf_chr${i}_${EXT}_snpname_filtersnp >> chrlist_tomerge1 ;
done
#try to merge with plink
plink --bfile 1000genomes_phase3_fromvcf_chr1_${EXT}_snpname_filtersnp --merge-list chrlist_tomerge1 --make-bed --out 1000g_merg${EXT}

MISSF=1000g_merg${EXT}-merge.missnp

##4.2 check if there is missing snp (triall)
if [ -f "$MISSF" ]; then
	##filter out triall var   #init file
	python ${DIR}/rmsnp.py chrlist_tomerge1 1000g_merg${EXT}-merge.missnp; > chrlist_tomerge2;
	#file with chr list
	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22; \
		do echo 1000genomes_phase3_fromvcf_chr${i}_${EXT}_snpname_filtersnp_rmsnp >> chrlist_tomerge2 ;
	done;
	#mergeeee
	plink --bfile 1000genomes_phase3_fromvcf_chr1_${EXT}_snpname_filtersnp_rmsnp --merge-list chrlist_tomerge2 --make-bed --out 1000g_merg${EXT}
fi

#475416 snp remaining

#################################
