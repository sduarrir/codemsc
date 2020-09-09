#!/usr/bin/env bash

####################Get PUNJABI SAMPLES##############
##1. FILTER FOR pnj
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr1 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr1_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr2 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr2_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr3 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr3_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr4 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr4_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr5 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr5_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr6 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr6_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr7 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr7_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr8 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr8_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr9 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr9_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr10 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr10_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr11 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr11_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr12 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr12_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr13 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr13_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr14 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr14_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr15 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr15_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr16 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr16_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr17 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr17_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr18 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr18_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr19 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr19_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr20 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr20_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr21 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr21_PJL
plink --bfile /gpfs/projects/lab_dcomas/1000genomes_phase3_dcomas/plink/1000genomes_phase3_fromvcf_chr22 --keep-fam PJL --make-bed --out 1000genomes_phase3_fromvcf_chr22_PJL

## 2. rename snp
python ../scripts/ids.py chrlist 

## 3. filter snp for each chr
python ../scripts/filtersnp.py chrlist_tofiltersnp commsnp_LAZ_FAGMER

##4.  merge all files
plink --bfile 1000genomes_phase3_fromvcf_chr1_PJL_snpname_filtersnp --merge-list chrlist_tomerge1 --make-bed --out 1000g_mergPJL
##surprise triallelic var are back again
## filter out triall var (14!)
python ../scripts/rmsnp.py chrlist_tomerge1 1000g_mergPJL-merge.missnp
##and now, merge
plink --bfile 1000genomes_phase3_fromvcf_chr1_PJL_snpname_filtersnp_rmsnp --merge-list chrlist_tomerge2 --make-bed --out 1000g_mergPJL
#475416 snp remaining

#################################





