import sys
import os

#FUNCTIONS
#output file name (action is the _ added)
def outputname(inputf, act, ext):
	try:
		name, _ = inputf.split('.') #make sure there is no extension
	except ValueError:
		name = inputf.strip()
	inputf = name +'.'+ ext
	outputf=name+'_'+act+'.'+ext
	return(inputf, outputf)

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

#renam
ext = 'snpname'
f = open(inputf, 'r')
for file in f:
        #get files + extension
	bed, bedf = outputname(file, ext, 'bed')
        bim,bimf = outputname(file, ext, 'bim')
        fam, famf = outputname(file, ext, 'fam')
        #print(bed, bim, fam)
	#print(bedf, bimf, famf)
	current = 'geting snp list from ' + bim + ' ...'
        print(current)

	#copy files
	command= '\\cp '+fam+ ' '+ famf
	os.system(command)
	command= '\\cp '+bed+ ' '+ bedf
        os.system(command)
	renam(bim, bimf)
f.close()
print("done!")

#outputf=outputname(inputf, 'renam')
#renam id
#renam(inputf, outputf)


