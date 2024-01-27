#!/bin/sh
rootDir=$pwd
type=$1
echo "#####################################################"
echo "############ MOVING GFF FILES #############"
echo "#####################################################"
mkdir -p "./results/$type/"
inDir="./results/$type/prokka_res"
peppanDir="./results/$type/peppan_res"
fasttreeDir="./results/$type/fasttree_res"
mkdir -p $outDir
mkdir -p $peppanDir
mkdir -p $fasttreeDir
for i in $(ls $inDir); do
	file=$(ls "$inDir/$i" | grep .gff)
	cp -fv "$inDir/$i/$file" $peppanDir
done
echo "#####################################################"
echo "############ peppan FUNCTION #############"
echo "#####################################################"
cd $peppanDir
PEPPAN *.gff
PEPPAN_parser -g PEPPAN.PEPPAN.gff -t -c -a 95
rm -v *.gff
echo "#####################################################"
echo "############ FASTTREE FUNCTION #############"
echo "#####################################################"
# FastTree -nt -gtr "core_gene_alignment.aln" >"../fasttree_res/tree_peppan.newick"
echo "#####################################################"
echo "############ !DONE!  #############"
echo "#####################################################"
