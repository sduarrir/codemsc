#!/usr/bin/env bash
## LAZARIDIS DATASET######
#working with non verbose pop names

# 1. create ped files tos work with plink
convertf -p convertlaz_tobedbimfam


# 2. file to change names w/ plink
paste HumanOriginsPublic2068.fam HumanOriginsPublic2068.ind | awk '{print $1 "\t" $2 "\t" $9 "\t" $7}' > oldtonew_ids
#modify (rel from (relative

# 3. change ids with plink
plink --bfile HumanOriginsPublic2068 --update-ids oldtonew_ids --make-bed --out HumanOriginsPublic2068_fnam


 ### try pca ###
# change to bed
#plink --bfile HumanOriginsPublic2068_fnam --recode --out HumanOriginsPublic2068_fnam
# smartpca
#smartpca -p parfile_pca_laz_maped


## 4. save just WEA pops (+ nordafrica, non verbose names)
plink --bfile HumanOriginsPublic2068_fnam --keep-fam popswea --make-bed --out HumanOriginsPublic2068_fnam_WEA
#621799 variants and 985 people


###control pca
#plink --bfile HumanOriginsPublic2068_fnam_WEA --recode --out HumanOriginsPublic2068_fnam_WEA
#smartpca -p parfile_pcaWEA_nofilt


## 5. Apply geno: exclude missing SNPs w/ freq >0.05
plink --bfile HumanOriginsPublic2068_fnam_WEA --geno 0.05 --make-bed --out HumanOriginsPublic2068_fnam_WEA_geno 
#11807 variants removed due to missing genotype data (--geno).
#609992 variants and 977 people pass filters and QC.


## 6. Apply mind: exclude individuals w/ missing data freq >0.1
plink --bfile HumanOriginsPublic2068_fnam_WEA_geno --mind 0.1 --make-bed --out HumanOriginsPublic2068_fnam_WEA_geno_mind
 #0 ppl removed

## 7. change  laz ids (.bim)
python ../scripts/ids.py tochangesnpid 
####### READY TO MERGE : HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname



#######################################

## 8. apply ld
plink --bfile HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname --indep-pairwise 200 25 0.5 --out HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname_ld
plink --bfile HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname --extract HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname_ld.prune.in --make-bed --out HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname_ld
#273348 variants and 894 people pass filters and QC.

##ld pca laz ##########################################
plink --bfile HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname_ld --recode --out HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname_ld
smartpca -p parfile_pca_laz > LAZ_pca.log
#####################################################





