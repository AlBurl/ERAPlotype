


#***********ERAPlotype**************
#July 2021


#add csv file name here (without.csv)
input.file <- 'file.name'

#master folder location
master.folder <- 'Enter/ERAPlotype/file/location here'


#************************************


library(dplyr)
library(stringr)
library(tidyr)
library(readr)

#user input file
input.path <- paste(master.folder,'/',input.file,".csv",sep = "")

#import WANNOVAR CSV file and assign to full.data
full.data <- read.csv(input.path,fill=TRUE,header=TRUE,stringsAsFactors = FALSE)

#remove unneccessary columns and assign to tidy.data
tidy.data <- full.data[c(1:7,9:11,17,33,34,46,52,58,110,127,132)]

ERAP1 <- filter(tidy.data, Gene.refGene == 'ERAP1')

#download HGNC database from online
HGNC.download <- 'http://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/tsv/locus_types/gene_with_protein_product.txt'
HGNC.name <- paste(master.folder,'/HGNC.txt',sep='')
download.file(HGNC.download,HGNC.name,mode='wb')

#import HGNC database
HGNC <- read.delim(HGNC.name,fill=TRUE,header=TRUE,stringsAsFactors = FALSE)

#match tables based on gene name 
All.rare.HGNC <- left_join(ERAP1, HGNC, by =c('Gene.refGene' = 'symbol'))

#removed unwanted columns and rename columns 
tidy.HGNC <- All.rare.HGNC[c(1:21,42)]

tidy.HGNC.2 <- tidy.HGNC %>%
  rename(HGNC_Match = name, HGNC_Ref_seq = refseq_accession)

#add columns with positions of correct transcript
ref.positions <- str_locate(tidy.HGNC.2$AAChange.refGene, tidy.HGNC.2$HGNC_Ref_seq)
HGNC.2 <- cbind(tidy.HGNC.2, ref.positions)

#add comma to end of variant column 
HGNC.2$AAChange.refGene <- paste(HGNC.2$AAChange.refGene, ',', sep="")

#extract transcript and variant into new column 'transcript_variant_int'
HGNC.3 <- HGNC.2 %>% 
  mutate(transcript.variant.int = str_sub(HGNC.2$AAChange.refGene, HGNC.2$start, -1))

#remove comma from the end of transcript variant 
HGNC.4 <- HGNC.3 %>%
  mutate(transcript.variant = str_sub(HGNC.3$transcript.variant.int, 1, (regexpr(',', HGNC.3$transcript.variant.int) -1)))

#extract DNA variant into new column 
DNA.variant.df <- HGNC.4 %>%
  mutate(DNA_variant = str_sub(HGNC.4$transcript.variant, (regexpr(':c.', HGNC.4$transcript.variant)+3), (regexpr(':p.', HGNC.4$transcript.variant) -1)))

#extract AA variant into new column 
AA.variant.df <- DNA.variant.df %>%
  mutate(AA_variant = str_sub(HGNC.4$transcript.variant, (regexpr(':p.', HGNC.4$transcript.variant)+3), -1))

#remove unwanted columns
DNA_AA_variant <- AA.variant.df[-c(22:24)]

#assign numbers to zygosity state
haplotype_1 <- DNA_AA_variant %>%
  mutate(zygosity = ifelse(grepl("het", DNA_AA_variant$Otherinfo), "", "2"))

#assign letters to ERAP1 haplotype-defining variants
haplotype_A <- haplotype_1 %>%
  mutate(variant = ifelse(grepl("Q730E", haplotype_1$AA_variant), "A",
                        ifelse(grepl("K528R", haplotype_1$AA_variant), "B",
                               ifelse(grepl("R127P", haplotype_1$AA_variant), "C",
                                      ifelse(grepl("I276M", haplotype_1$AA_variant), "D",
                                             ifelse(grepl("D575N", haplotype_1$AA_variant), "E",
                                                    ifelse(grepl("G346D", haplotype_1$AA_variant), "F",
                                                           ifelse(grepl("E56K", haplotype_1$AA_variant), "G",
                                                                  ifelse(grepl("R725Q", haplotype_1$AA_variant), "H",
                                                                         ifelse(grepl("M349V", haplotype_1$AA_variant), "I", ""))))))))))
                            

#delete rows with non haplotype-defining variants 
haplotype_A_tidy<-subset(haplotype_A, variant!="")

#combine zygosity and variant codes
haplotype_1A <- haplotype_A_tidy %>%
  mutate(combined = paste(zygosity,variant,sep=''))

#order
haplotype_1A_order <- haplotype_1A[order(haplotype_1A$variant),]

#combine codes into one string
out <- paste(haplotype_1A_order$combined, collapse='+')

#import references database
ERAP_path <- paste(master.folder,'/ERAP_ref_df.csv',sep = "")
ERAP_ref <- read.csv(ERAP_path,fill=TRUE,header=TRUE,stringsAsFactors = FALSE)

#find match in reference database
inter <- which(ERAP_ref == out, arr.ind = TRUE)

#generate haplotype
rtrn_hap <- paste('Hap',inter[1],'/','Hap',inter[2],sep='')

#return haplotype
if (rtrn_hap == 'Hap4/Hap1') {
  
  print('Hap4/Hap1 OR Hap6/2. Cannot be distinguished')

  }else{
  
    print(rtrn_hap)  
}







