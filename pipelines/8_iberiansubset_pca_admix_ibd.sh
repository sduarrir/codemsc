#!/usr/bin/env bash
###SUBSET SPAIN##

## CREATE SUBSET###

#1. subset
plink --bfile mergeLAZ_FAGMER_comsnp_ld --keep-fam spn_subset --make-bed --out iberianpeninsula 

#2. change to verbose labels
plink --bfile iberianpeninsula --update-ids verboseids --make-bed --out iberianpeninsula_ids
#file made with excel

#3. Remove french basques
plink --bfile iberianpeninsula_ids --remove-fam frenchbasques --make-bed --out iberianpeninsula_ids_nofr

#4. Extract Mozabite from lazaridis (original subset
plink --bfile mergeLAZ_FAGMER_comsnp_ld --keep-fam mozabite --make-bed --out mozabite

#5. Merge w/ mozabites -> 2 subsets : w/ and w/o mozabites
plink --bfile iberianpeninsula_ids_nofr --bmerge  mozabite --allow-no-sex --make-bed --out merge_iberian_mozabite


####PCA : subset w/o Mozabites
plink --bfile iberianpeninsula_ids_nofr --recode --out iberianpeninsula_ids_nofr
smartpca -p parfile_pca_spain

##pac w moz
plink --bfile merge_iberian_mozabite --recode --out merge_iberian_mozabite
smartpca -p parfile_pca_spain_wmoz

#pca  no moz no can


###ADMIXTURE subset w/ Mozabites : admixture folder

##1. admixture
#to get a random seed (in adm folder)
admixture --cv iberianpeninsula_ids_nofr.bed -s time 2  
##here the important part is -s time, theres no neet that the file even exists
#for every seed (in each seed folder)
bash ../../../masterthesis/scripts/admixture.sh  ../../merge_iberian_mozabite.bed  $SEED


###2. PONG
#popind file
cat ../merge_iberian_mozabite.fam | awk '{print $1}' > popind_iberian
#pop order
cat popind_iberian | uniq > poporder_iberian #manually edited later
#pop names
cp poporder_iberian popnames_iberian #manually edited
## filemap, in admixture folder
bash getfilemap.sh merge_iberian_mozabite filemap_iberian

##pong
pong -m filemap_iberian -n popnames_iberian -i popind_iberian
##pong with separated pops #mercheros manually edited (2)
pong -m filemap_iberian -n popnames_iberian -i popind_iberian2 -l ../../admixture/paletapong.txt


### Admixture without mozabites
bash ../../../masterthesis/scripts/admixture.sh  ../../iberianpeninsula_ids_nofr.bed  $SEED
# 1. filemap
bash getfilemap.sh iberianpeninsula_ids_nofr filemap_iberian2
# 2. pop ind
cat ../iberianpeninsula_ids_nofr.fam |awk '{print $1}' > popind_iber2
#add manually mercheros
# 3. pop order(same as previous) `+ remove mzbite
cp ../admixture/poporder_iberian2 poporder_iber2

###pong
pong -m filemap_iberian2 -n poporder_iber2 -i popind_iber2 
pong -m filemap_iberian -i popind_iberian

############################################################################
CV ERROR
grep -h CV seed$SEED_*/log*.out
####################################################################3



##IBD
##new dataset !!! (without ld!)
cp ../merge/mergeLAZ_FAGMER_comsnp.* ./
plink --bfile mergeLAZ_FAGMER_comsnp --keep-fam spn_subset --make-bed --out iberianpeninsula_allsnp
plink --bfile iberianpeninsula_allsnp --update-ids verboseids --make-bed --out iberianpeninsula_allsnp_ids

##recode
plink --bfile iberianpeninsula_allsnp_ids --recode vcf --out iberianpeninsula_allsnp_ids
module load Java/12.0.2 
sbatch --job-name=ibd --nodes=1 --ntasks-per-node=1 --output=ibd_iberian.out --wrap="module load Java/12.0.2; java -Xmx8g -jar ibd/ibdseq.r1206.jar gt=iberianpeninsula_allsnp_ids.vcf out=iberianpeninsula_allsnp_ids_ibd"





