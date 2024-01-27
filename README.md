
# Steps to reproduce:

## Installing the environment

It is recommended to run the scripts on a Ubuntu LTS
environment. We used Ubuntu server LTS version. [Bash](https://www.gnu.org/software/bash/) is required for executing the scripts in this project.

For Prokka and PEPPAN, please install [Conda](https://conda.io/projects/conda/en/latest/user-guide/install/index.html). Afterwards, access your terminal and create a new conda environment:

```
conda create --name <name>
```

Follow the prompts and select the default parameters.


Next, enter the conda environment:

```
conda activate <name>
```

And install [Prokka](https://github.com/tseemann/prokka) and [PEPPAN](https://github.com/zheminzhou/PEPPAN/blob/master/docs/source/usage/installation.rst):

```
conda install -c conda-forge -c bioconda -c defaults prokka
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda install mmseqs2
conda install blast
conda install diamond
conda install rapidnj
conda install fasttree

```

For [Roary](https://github.com/sanger-pathogens/Roary/blob/master/README.md) and [FastTree](http://www.microbesonline.org/fasttree/), we utilized the Ubuntu versions available through `apt`:

```
# for roary
sudo apt-get install bedtools cd-hit ncbi-blast+ mcl parallel cpanminus prank mafft fasttree
sudo cpanm -f Bio::Roary
# for fasttree
sudo apt install fasttree
```


Lastly, for downloading of files, download R.

```
sudo apt install r-base
```

## Running the scripts

Download the `FASTA` files associated with the bacterial and plasmid genomes by executing the `s0_` script in R.

```
Rscript ./code/s0_download_Fasta.R

```

Next run Prokka on the downloaded `FASTA` files by executing the `s1_` bash script with either `bacterial` or `plasmid` arguments (for the bacterial and plasmid genomes, respectively)

```
bash ./code/s1_prokka.sh plasmid
bash ./code/s1_prokka.sh bacterial
```

For bacterial genome, execute the `./s2_` script:

```
./code/s2_roary.sh bacterial
```

And for the plasmid genome, execute the `./s3_` script:

```
./code/s3_peppan.sh plasmid
```

### Results

For the bacterial genome, the resulting `newick` file is available at `./results/bacterial/fasttree_res/tree.newick`. 
For the plasmid genome, the resulting `newick` file is available at `./results/plasmid/peppan_res/PEPPAN.PEPPAN.gene_content.nwk`
