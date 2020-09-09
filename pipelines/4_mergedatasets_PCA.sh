#!/usr/bin/env bash

####MERGE FAG, MER + LAZARIDIS#################

#1. try merge
plink --bfile HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname --bmerge  plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd_FAGMER_snpname --allow-no-sex --make-bed --out mergeLAZ_FAGMER

# 2. rm trial from dataset (fag mer)
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd_FAGMER_snpname --exclude mergeLAZ_FAGMER-merge.missnp --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd_FAGMER_snpname_nontri

#3. re try merge
plink --bfile HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname --bmerge  plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd_FAGMER_snpname_nontri --allow-no-sex --make-bed --out mergeLAZ_FAGMER

#609992 markers loaded from HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname.bim. 
#485915 markers to be merged from plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd_FAGMER_snpname_nontri.bim.
#6151 are new, while 479764 are present in the base dataset.

## 4. list of snp from each dataset
python ../scripts/snplist.py  HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname.bim plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd_FAGMER_snpname_nontri.bim

## 5.commonsnp from two lists
comm -12 <(sort plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd_FAGMER_snpname_nontri_snplist ) <(sort HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname_snplist) > commsnp_LAZ_FAGMER
#479764 snps

## 6. extract common snp from merged dataset
plink --bfile mergeLAZ_FAGMER --extract commsnp_LAZ_FAGMER --make-bed --out mergeLAZ_FAGMER_comsnp
#479764 variants and 1060 people

## 7. apply ld
plink --bfile mergeLAZ_FAGMER_comsnp --indep-pairwise 200 25 0.5 --out mergeLAZ_FAGMER_comsnp_ld
plink --bfile mergeLAZ_FAGMER_comsnp --extract mergeLAZ_FAGMER_comsnp_ld.prune.in --make-bed --out mergeLAZ_FAGMER_comsnp_ld
#218042 variants remaining.

############################################################################

############PCA LAZ +FAGMER #########################################
# 1. recode with plink:Convert files to use them with eigensoft software
plink --bfile mergeLAZ_FAGMER_comsnp_ld --recode --out mergeLAZ_FAGMER_comsnp_ld
        # 0.5 create ped file

# 2. smartpca
smartpca -p parfile_pca_laz_fagmer > mergeLAZ_FAGMER_comsnp_ld_pca.log
        # 1.5 create parfile: numoutlieriter equal to = (avoid removing outliers!!)

#############################


########### MERGE 100k + laz + fm########################
##1. Try merge, see what happens
plink --bfile mergeLAZ_FAGMER_comsnp --bmerge 1000g_mergPJL --allow-no-sex --make-bed --out mergeLAZ_FAGMER_PJL
#oh! triallelic variants

## 2. rm problematic variants
plink --bfile 1000g_mergPJL --exclude mergeLAZ_FAGMER_PJL-merge.missnp --make-bed --out 1000g_mergPJL_rmsnp  
#475407 variants remaining

## 3. merge
plink --bfile mergeLAZ_FAGMER_comsnp --bmerge 1000g_mergPJL_rmsnp --allow-no-sex --make-bed --out mergeLAZ_FAGMER_PJL
#479764 markers loaded from mergeLAZ_FAGMER_comsnp.bim.
#475370 markers to be merged from 1000g_mergPJL_rmsnp.bim.
#1156 people


## 3. list of snp from each dataset
python ../scripts/snplist.py mergeLAZ_FAGMER_comsnp.bim 1000g_mergPJL_rmsnp.bim

## 4.common snp from two lists
comm -12 <(sort mergeLAZ_FAGMER_comsnp_snplist) <(sort 1000g_mergPJL_rmsnp_snplist) > commsnp_LAZ_FAGMER_PJL
#479815 snps

## 5. extract common snp from merged dataset
plink --bfile mergeLAZ_FAGMER_PJL --extract commsnp_LAZ_FAGMER_PJL --make-bed --out mergeLAZ_FAGMER_PJL_comsnp

## 6. apply ld
plink --bfile mergeLAZ_FAGMER_PJL_comsnp --indep-pairwise 200 25 0.5 --out mergeLAZ_FAGMER_PJL_comsnp_ld
plink --bfile mergeLAZ_FAGMER_PJL_comsnp --extract mergeLAZ_FAGMER_PJL_comsnp_ld.prune.in --make-bed --out mergeLAZ_FAGMER_PJL_comsnp_ld
#217234 variants and 1156 people pass filters and QC.
#MODIFY: colum 5 change -9 (pjl) to 1


################PCA LAZ, FAGMER, PJL#################
# 1. recode with plink:Convert files to use them with eigensoft software
plink --bfile mergeLAZ_FAGMER_PJL_comsnp_ld --recode --out mergeLAZ_FAGMER_PJL_comsnp_ld
        # 0.5 create ped file

# 2. smartpca
smartpca -p parfile_pca_laz_fagmer_pjl > mergeLAZ_FAGMER_PJL_comsnp_ld_pca.log
        # 1.5 create parfile: numoutlieriter equal to = (avoid removing outliers!!)

#############################








