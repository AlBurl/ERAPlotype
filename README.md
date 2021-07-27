# ERAPlotype

**ERAPlotype determines the ERAP1 haplotype from whole exome sequencing data.**

## Introduction

Endoplasmic reticulum aminopeptidase 1 (ERAP1) is an important protein for processing and transport in the endoplasmic reticulum. Due to its involvement in the processing of peptides prior to MHC-I presentation, mutations in ERAP1 that alter its activity are associated predisposition to certain autoinflammatory diseases. 

There are defined naturally occuring haplotypes of ERAP1, which reflect different combinations of single nucleotide polymorphisms. Although the full implications of these haplotypes remain unknown, certain haplotypes have been associated with specific diseases. For example, HLA-B-51+ individuals homozygous for ERAP1 Hap10 have been found to have around a 3x higher predisposition to Behcet's Disease than HLA-B-51 individuals with other ERAP1 haplotypes.

Where ERAP1 haplotypes are traditionally determined through genotyping assays or manual sequence scrutiny, ERAPlotype determines both ERAP1 haplotypes from whole exome sequencing data. 

## Functionality

ERAPlotype takes input of an annotated csv file (which can be generated quickly and freely from a vcf file through [wANNOVAR](http://wannovar.wglab.org). ERAPlotype filters this file for ERAP1 variants, and then computes both ERAP1 haplotypes based on the combination of mutations present.

ERAPloype uses the definition of ERAP1 haplotypes as described in [Ombrello et al, 2015](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4565054/).

## Requirements 

ERAPlotype uses [RStudio](https://www.rstudio.com/products/rstudio/) and the following R packages:
1.	Dplyr
2.	Readr
3.	Stringr
4.	Tidyr

## Usage

1. Create a file named 'ERAPlotype'.
2. Download the ERAPlotype R script and install packages accordingly using install.packages(). 
3. Download the ERAP_ref_df.csv to ERAPlotype folder.
4. If file for analysis is in VCF format, annotate the file at [wANNOVAR](http://wannovar.wglab.org). 
5. Download the resulting exome csv file to ERAPlotype folder.
6. Enter file name where indicated within script. 
7. Run script. 
8. ERAP1 haplotypes HapA/HapB are printed.   

## Contact 

Alice Burleigh

alice.burleigh.19@ucl.ac.uk

University College London Great Ormond Street Institute of Child Health

## References 

If you use ERAPlotype, please reference ANNOVAR accordingly:

Wang, K., M. Li, and H. Hakonarson. 2010. 'ANNOVAR: functional annotation of genetic variants from high-throughput sequencing data', Nucleic Acids Research, 38: e164-e64.








