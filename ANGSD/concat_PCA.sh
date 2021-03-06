#!/bin/bash

SAMPLE=$1
INTERVALS=$2
DIRECTORY=$3

COUNT=0

#Check if all files are present
for i in $(seq 1 ${INTERVALS})

do
if [ -f ${DIRECTORY}/${SAMPLE}_Int$i.mafs.gz ]
then
COUNT=$(($COUNT+1))

else
echo ${SAMPLE}_Int$i missing file
fi

done


#If all files present copy first file to a new file to hold concatenated results and gunzip
if [ "$COUNT" -eq ${INTERVALS} ]

then	
	cp ${DIRECTORY}/${SAMPLE}_Int1.mafs.gz ${DIRECTORY}/${SAMPLE}_cat.mafs.gz
	gunzip ${DIRECTORY}/${SAMPLE}_cat.mafs.gz
	
	cp ${DIRECTORY}/${SAMPLE}_Int1.geno ${DIRECTORY}/${SAMPLE}_cat.geno
	
	for i in $(seq 2 ${INTERVALS})
		do	
		zcat ${DIRECTORY}/${SAMPLE}_Int$i.mafs.gz | tail -n +2 >> ${DIRECTORY}/${SAMPLE}_cat.mafs
		cat ${DIRECTORY}/${SAMPLE}_Int$i.geno >> ${DIRECTORY}/${SAMPLE}_cat.geno
		done
	
	gzip  ${DIRECTORY}/${SAMPLE}_cat.mafs

else
	echo Something is wrong
fi