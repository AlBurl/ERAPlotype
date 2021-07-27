# ERAPlotype

**ERAPlotype determines the ERAP1 haplotype from whole exome sequencing data.**

## Introduction

Endoplasmic reticulum aminopeptidase 1 (ERAP1) is an important protein for processing and transport in the endoplasmic reticulum. Due to its involvement in the processing of peptides prior to MHC-I presentation, mutations altering ERAP1 activity are associated predisposition to certain autoinflammatory diseases. 

There are 10 naturally occuring haplotypes of ERAP1, which reflect different combinations of single nucleotide polymorphisms. Although the full implications of these haplotypes remain unknown, certain haplotypes have been associated with specific diseases. For example, HLA-B-51+ individuals homozygous for ERAP1 Hap10 have been found to have around a 3x higher predisposition to Behcet's Disease that HLA-B-51 individuals with other ERAP1 haplotypes.

Where ERAP1 haplotypes are traditionally determined through genotyping assays or sequence scrutiny, ERAPlotype determines both ERAP1 haplotypes from whole exome sequencing data. 

## Method

ERAPlotype takes input of an annotated csv file (which can be generated quickly and freely from a vcf file through wANNOVAR.com). ERAPlotype filters this file to ERAP1 variants, and then computes both ERAP1 haplotypes based on the combination of mutations present. 





