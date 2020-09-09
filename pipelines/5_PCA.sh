#!/usr/bin/env bash
## LAZARIDIS WEA + FAG MER DATASET######

########## european + caucasus + turquia + fag + mer
## 1. extract pops
plink --bfile mergeLAZ_FAGMER_comsnp_ld --keep-fam  popseurope_fagmer_withrusia --make-bed --out mergeLAZ_FAGMER_comsnp_ld_eurwrussia
# 679 people

## 2. convert to ped 
plink --bfile mergeLAZ_FAGMER_comsnp_ld_eur --recode --out mergeLAZ_FAGMER_comsnp_ld_eur

## 3. smartpca
smartpca -p parfile_pca_eur >  mergeLAZ_FAGMER_comsnp_ld_eur_pca.log


############## just european + fag + mer
## 1. extract pops
plink --bfile mergeLAZ_FAGMER_comsnp_ld --keep-fam  popseurope_fagmer --make-bed --out mergeLAZ_FAGMER_comsnp_ld_eur
#621799 variants and 985 people

## 2. convert to ped 
plink --bfile mergeLAZ_FAGMER_comsnp_ld_eur --recode --out mergeLAZ_FAGMER_comsnp_ld_eur

## 3. smartpca
smartpca -p parfile_pca_eur >  mergeLAZ_FAGMER_comsnp_ld_eur_pca.log

############## some european + mer
## 1. extract pops
plink --bfile mergeLAZ_FAGMER_comsnp_ld --keep-fam  popsubseteurope_mer --make-bed --out mergeLAZ_FAGMER_comsnp_ld_eur_nofag
#621799 variants and 985 people

## 2. convert to ped 
plink --bfile mergeLAZ_FAGMER_comsnp_ld_eur_nofag --recode --out mergeLAZ_FAGMER_comsnp_ld_eur_nofag

## 3. smartpca
smartpca -p parfile_pca_eur_nofag >  mergeLAZ_FAGMER_comsnp_ld_eur_nofag_pca.log

############## spain + mer + france + north italie
## 1. extract pops
plink --bfile mergeLAZ_FAGMER_comsnp_ld --keep-fam  pops_spain_peri --make-bed --out mergeLAZ_FAGMER_comsnp_ld_spain
#621799 variants and 985 people

## 2. convert to ped 
plink --bfile mergeLAZ_FAGMER_comsnp_ld_spain --recode --out mergeLAZ_FAGMER_comsnp_ld_spain

## 3. smartpca
smartpca -p parfile_pca_spain >  mergeLAZ_FAGMER_comsnp_ld_spain_pca.log


## PCA W/O CANARY
plink --bfile mergeLAZ_FAGMER_comsnp_ld_spain --remove-fam can --make-bed --out mergeLAZ_FAGMER_comsnp_ld_spain_nocan
plink --bfile mergeLAZ_FAGMER_comsnp_ld_spain_nocan --recode --out mergeLAZ_FAGMER_comsnp_ld_spains 









