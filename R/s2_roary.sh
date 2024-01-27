#!/bin/sh
rootDir=$pwd
type=$1
echo "#####################################################"
echo "############ MOVING GFF FILES #############"
echo "#####################################################"
mkdir -p "./results/$type/"
inDir="./results/$type/prokka_res"
roaryDir="./results/$type/roary_res"
fasttreeDir="./results/$type/fasttree_res"
mkdir -p $outDir
mkdir -p $roaryDir
mkdir -p $fasttreeDir
for i in $(ls $inDir); do
	file=$(ls "$inDir/$i" | grep .gff)
	cp -fv "$inDir/$i/$file" $roaryDir
done
echo "#####################################################"
echo "############ ROARY FUNCTION #############"
echo "#####################################################"
cd $roaryDir
roary -e -n -v -a *.gff
# roary -e -n -v -a -cd 80 -i 95 *.gff #  -s -i 90 -ap
##############################################################################
# https://bmcmicrobiol.biomedcentral.com/articles/10.1186/s12866-022-02546-6
# In order to determine the core- and pangenome, annotated gff files were then
# used as an input for multi-sequence alignment using Roary [24] with minimum
# percentage identity of 60%.
#
# roary -e -n -v -a -i 60 *.gff
##############################################################################
# https://royalsocietypublishing.org/doi/10.1098/rstb.2021.0245
# All genes present in at least two samples were included in the alignment, as
# opposed to core genes only (set with the core definition parameter cd =
# 0.08).
#
# roary -e -n -v -a -cd 0.08 *.gff
##############################################################################
# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10074901/
# recombination, gene gain and loss, and potentially assembly errors made it
# difficult to perform whole plasmid alignment, so Roary was used to find the
# core genes (> 95% identity, 100% of isolates must have gene to be core),
# which were then concatenated and aligned by Roary using MAFFT (v7.305b) [61].
#
# roary -e -n -v -a -cd 100 -i 95 *.gff
# The predicted genes were clustered with Roary (v3.12.0) [56] to identify the
# pangenome of the clinical clade using 90% identity for clustering and
# requiring that 99% of isolates possess a gene to be considered core.
# roary -e -n -v -a -cd 99 -i 90 *.gff
##############################################################################
# https://www.frontiersin.org/articles/10.3389/fmicb.2021.660920/full
# For Roary and PEPPAN, GFF files were used while for PanX, GenBank archives.
# Roary was run with ‘-e -n -p 24 -v -r -i 80 –group_limit 100000’ options.
# roary -e -n -p 24 -v -r -i 80 *.gff
##############################################################################
# roary -e -n -v -a *.gff
#
# roary -s -ap -i 80 -cd 0.08 *.gff
# --iterative_refinement
rm -v *.gff
echo "#####################################################"
echo "############ FASTTREE FUNCTION #############"
echo "#####################################################"
FastTree -nt -gtr "core_gene_alignment.aln" >"../fasttree_res/tree.newick"
echo "#####################################################"
echo "############ !DONE!  #############"
echo "#####################################################"
