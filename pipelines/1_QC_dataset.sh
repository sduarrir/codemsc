#!/usr/bin/env bash
##QUALITY FILTERS

#1. exclude missing SNPs w/ freq >0.05
##	--write-snplist writes IDs of all variants which pass the filters and inclusion thresholds you've specified to plink.snplist
###plink --file mydata --geno 0.05 --out makebed
plink --bfile plate_1_2_3_11122019_autosomes --geno 0.05 --make-bed --out plate_1_2_3_11122019_autosomes_geno
 #1 snp removed 

#2. exclude individuals w/ missing data freq >0.1
###plink --mind 0.1
plink --bfile plate_1_2_3_11122019_autosomes_geno --mind 0.1 --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind
 #0 ppl removed

# 3. filter by HW criteria, significant OUT P-value = 10-5
###plink --file _indout. --hwe 10e-5 --out _hw. #now sue si esta bien puesto el num
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind --hwe 0.00001 --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe
 #1048 variants removed

# 4. Exclude SNP with MAF < 0.01 (could be a sequencing error)
###plink --maf #by deffault is 0.01
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe --maf --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf
 #113167 variants removed due to minor allele threshold(s)

########  HERE WE HAVE OUR DATA READY FOR NOR FREQ ANALYSIS ########


### *) look for contamination or exess or missing data (recheck)

#5.1 Heterozigosis estimation
##--freqx writes a more informative genotype count report to plink.frqx.
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf --freqx --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_freqx
#byind
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf --het --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_het
 
#5.2 Proportion of missing data
##Missing data --missing ['gz']
##--missing produces sample-based and variant-based missing data reports. If run with --within/--family, the variant-based report is stratified by cluster. 'gz' causes the output files to be gzipped.
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf --missing --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_missing
 #Total genotyping rate is 0.995984. no variants were filtered out



###  *) preapare data for freq analysis (PCA, with eigensoft)

# 6. Linkage-desequilibrium -> Obtain TAG-SNPs
# 	windows size = 200kb (kb as def), step size = 25, R2 > 0,05 OUT
##--indep-pairwise <window size>['kb'] <step size (variant ct)> <r^2 threshold>
###plink --indep-pairwise 200 25 0.5
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf --indep-pairwise 200 25 0.5 --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld
 #make-bed is not necessary . list of records IN in .in
 #254427 of 486009 variants removed.

#now filter (for real the file)
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf --extract plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld.prune.in --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld 
	#the data that is selected on 

######### SMART PCA #########
# 1. convertf :Convert files to use them with eigensoft software
convertf -p par.PLINK.EIGENSTRAT
	# 0.5 create par file: from bed, bim, fam to geno, snp, ind  (EIGENSTRAT)

# 2. smartpca
smartpca -p parfile_pca > plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_pca.log
	# 1.5 create parfile: numoutlieriter equal to = (avoid removing outliers!!)

#############################



### 7. estimate ibd (all pop together) - IDENtity by descent
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld --genome --min 0.125 --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_ibd
##7.1 check ind
awk '{print $2, $4}' plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_ibd.genome | tr ' ' '\n' | sort | uniq -c | sort
wc -l plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_ibd.genome

##7.2 filter out - avoid 2 ind with more than 0.125 rel coef (3rd degree familiars)
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld --remove rm_ind --make-bed --out  plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_ibd
#rm 13 ind (9 fag, 3 mer, 1 res)


### 8. extract different populations (#fag - 75, #mer - 20, #swe - 16, #res - 10) 
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_ibd --keep-fam pop_list --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_ibd_FAGMERSWERES
#just mer and fag
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_ibd --keep-fam pop_list --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ld_ibd_FAGMER


###9. Extract mer and fag but w/o linkage desequilibrium applied
#rm 1 and 2nd degree
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf --remove rm_ind --make-bed --out  plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd
#extract mer and fag
plink --bfile plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd --keep-fam pop_list --make-bed --out plate_1_2_3_11122019_autosomes_geno_mind_hwe_maf_ibd_FAGMER 


## 10. change  laz ids (.bim)
python ../scripts/ids.py tochangesnpid 
####### READY TO MERGE : HumanOriginsPublic2068_fnam_WEA_geno_mind_snpname







