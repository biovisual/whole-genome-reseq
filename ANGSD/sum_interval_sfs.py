#! /usr/bin/env python

import re, sys, os, itertools, sets, getopt        # Load standard modules I often use
import numpy, gzip

'''
Takes a directory (-f, <default .>) and cycles through sfs results to sum across -n <default 20> intervals. Set up to work with a specific sample name (-s <sample name> as sample_genome.sfs. 
'''

def main(argv):
	try:
		opts,args = getopt.getopt(argv,'hd:s:n:')
	except getopt.GetOptError:
		print "sum_interval_sfs.py -d <directory> -s <sample name> -n <number of intervals default 20>"
		sys.exit(2)
			
	directory = "."
	sampleName=""
	nintervals = 20

	for opt, arg in opts:
		if opt == "-h":
			print "sum_interval_sfs.py -d <directory> -s <sample name> -n <number of intervals default 20>"
			sys.exit(2)
		elif opt == "-d":
			directory = arg
		elif opt == "-s":
			sampleName = arg
		elif opt == "-n":
			nintervals = int(arg)

	output = open(directory+"/"+sampleName+"_Genome.sfs","w")
	
	new_sfs = []
	
	for i in range(1,(nintervals+1)):
		interval = open(directory+"/"+sampleName+"_Int"+str(i)+".sfs","r")
		for line in interval:
			line = line.strip().split(" ")
			if i == 1:
				for j in range(0,len(line)):
					new_sfs.append([float(line[j])])
			else:
				for j in range(0,len(line)):
					new_sfs[j].append(float(line[j]))
		interval.close()
	
	new_sfs_summed = []
	for bin in new_sfs:
		new_sfs_summed.append(str(sum(bin)))
				
	new_sfs_summed = " ".join(new_sfs_summed)
	
	output.write(new_sfs_summed)			
					
	output.close()


if __name__ == "__main__":
		main(sys.argv[1:])