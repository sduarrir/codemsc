import sys
import os

#FUNCTIONS
#output file name (action is the _ added)
def outputname(inputf, act):
	try:
		name, _ = inputf.split('.') #make sure there is no extension
	except ValueError:
		name = inputf.strip()
	outputf=name+'_'+act
	return(name, outputf)

#change id for chr_pos
def renam(inputf, outputf):
	#open file
	f = open(inputf, "r")
	wf = open(outputf, "w")

	for line in f:
        	elem=line.split('\t')
        	chrid=elem[0]+'_'+elem[3]
        	elem[1]=chrid
        	nline = '\t'.join(elem)
		wf.write(nline)
	f.close()
	wf.close()
#get inputfile
inputf = sys.argv[1]
snplist = sys.argv[2]
#renam
ext = 'rmsnp'
f = open(inputf, 'r')
for file in f:
	#file w/ no extension
	#get files + what is done to them ( no extension
        inpf, outf = outputname(file, ext)
	command = 'plink --bfile ' + inpf +' --exclude '+ snplist + ' --make-bed --out ' + outf
	#print current file
	current = '####################filtering snps from ' + inpf + ' ...##########################'
        print(current)
	# execute plink
        os.system(command)

f.close()
print("done!")

#outputf=outputname(inputf, 'renam')
#renam id
#renam(inputf, outputf)


