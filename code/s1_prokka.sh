#!/bin/sh
rootDir=$pwd
type="plasmid"
echo $rootDir
echo $type
inDir="./data/fasta_files_$type"
outDir="./results/$type/prokka_res"
mkdir -p $outDir
echo "#####################################################"
echo "############ START OF PROKKA FUNCTION #############"
echo "#####################################################"
for i in $(ls $inDir); do
	# clean gene ame
	name=$(echo $i | awk '{gsub(/.fasta/, "", $0); print}')
	echo "Analysing for $name"
	echo "Input file is $inDir/$i"
	echo "Output folder is $outDir/$name/"
	# prokka --outdir "$outDir/$name" --prefix $name "$inDir/$i"
	prokka --kingdom Bacteria --outdir "$outDir/$name" --prefix $name "$inDir/$i"
done
