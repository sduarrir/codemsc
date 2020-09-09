#!/usr/bin/env bash

####################Get yoruba an ceu samples##############
bash merge1kdataset.sh  YRICEU YRI_CEU ../../admixture/dataaset_PJL/commsnp_LAZ_FAGMER ../../scripts


#0.5 in yrb_ceu dataset
bash merge1kdataset.sh  YRICEU YRI_CEU ../../admixture/dataaset_PJL/commsnp_LAZ_FAGMER ../../scripts


#1. command to merge datasets
bash merge2datasets.sh mergeLAZ_FAGMER_PJL_comsnp 1000g_mergYRI_CEU mergeLAZ_FM_PJLYRICEU ../scripts

#2. change -9 after ld  (for 1 )
#manually

#3. runs of homocigosisty
plink --bfile mergeLAZ_FM_PJLYRICEU_comsnp_ld --homozyg --homozyg-density 50 --homozyg-gap 100 --homozyg-kb 500 --homozyg-snp 50 --homozyg-window-het 1 --homozyg-window-missing 5 --homozyg-window-snp 50 --homozyg-window-threshold 0.05

