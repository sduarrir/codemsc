###############IMPUT  SCRIPT + W/ ALL THE FILES (AS ARGV) THAT YOU WANT TO GET ITS SNP LIST #########33
#example : python snplist.py file1.bim file2.bim [...] fileN.bim

import sys

#FUNCTIONS
def outputname(inputf, act):
        name, _ = inputf.split('.')
        outputf=name+'_'+act
        return(outputf)


#get a list of present snp in file
def makelist (inputf, outputf):
        #open file
        f = open(inputf, "r")
        wf = open(outputf, "w")

        for line in f:
                elem=line.split('\t')
                wf.write(elem[1])
		wf.write("\n")
        f.close()
        wf.close()


#get inputfile

for file in sys.argv[1:]:
	current = 'geting snp list from ' + file + ' ...'
	print(current)
	outputf = outputname(file, 'snplist')
	makelist(file, outputf)

print("done!")



