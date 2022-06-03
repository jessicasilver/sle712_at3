### SLE712 AT3: Bioinformatics Assignment

Jessica Silver (211297139)

source: https://github.com/jessicasilver/sle712_at3


Date commenced: 2022-05-07

Date submitted: 2022-06-03

***


This repo contains 3 files: README.md, Rscript (sle712_scriptCLEAN.R) and RMarkDown (SLE712_AT3_JSILVER.rmd) files.


sle712_scriptCLEAN.R contains working code and comments generated while working through AT3 questions. Personal use. 

SLE712_AT3_JSILVER.rmd and SLE712_AT3_JSILVER.html were exported and submitted to the SLE712 assignment dropbox. Code chunks can be found in these documents.

***

#### Introduction

This Rmarkdown document contains written answers to Part 1 (Q1-10) and Part 2 (Q1-6) of SLE712: AT3 - Bioinformatics Report. 

**Part 1:** 

Q1-5 relate to gene expression data from three samples (accessible [here](https://github.com/markziemann/SLE712_files/blob/master/assessment_task3/bioinfo_asst3_part1_files/gene_expression.tsv)). 
Q6-10 relate to tree growth data collected from two sites during a longitudinal study (accessible [here](https://github.com/markziemann/SLE712_files/blob/master/assessment_task3/bioinfo_asst3_part1_files/growth_data.csv))


To access each dataset, follow the link above, right click on the appropriate file name and "copy link address". Each file was read into Rstudio and is detailed in the code chunks below. 


**Part 2:**

The [E. Coli](http://ftp.ensemblgenomes.org/pub/bacteria/release-53/fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655_gca_000005845/) and [H. Anseris](http://ftp.ensemblgenomes.org/pub/bacteria/release-53/fasta/bacteria_51_collection/helicobacter_anseris_gca_003364335/) coding sequence datasets were downloaded from [Ensembl](https://bacteria.ensembl.org/info/data/ftp/index.html).


To access the compressed fasta files, click on the "cds" folder, right click on the file and "copy link address". For convenience, these links are also embedded into the code chunks below. 

***

#### Part 1 Answers

**Part 1 Question 1: ** See Table 1 in Rmd document

**Part 1 Question 2: ** See Table 2 in Rmd document 

**Part 1 Question 3: ** See Table 3 in Rmd document 

**Part 1 Question 4: ** There are *35,869 genes* with a mean expression less than 10. 

**Part 1 Question 5: ** See Figure 1A and Figure 1B in Rmd document 

**Part 1 Question 6: ** The column names are: Site, Tree ID, Circumf_2005_cm, Circumf_2010_cm, Circumf_2015_cm, and Circumf_2020_cm.

**Part 1 Question 7: ** 

NEsite_2005 Mean =  5.29  SD =  0.914

NEsite_2020 Mean =  54.2  SD =  25.2

SWsite_2005 Mean =  4.86  SD =  1.15

SWsite_2020 Mean =  45.6  SD =  17.9

**Part 1 Question 8: ** See Figure 2 in Rmd document 

**Part 1 Question 9: **

NEsite: The mean growth over the past ten years was 42.94 cm

SWsite: The mean growth over the past ten years was 35.49 cm

**Part 1 Question 10: **

T-TEST: Mean growth is not significantly different (p=0.0623) between the NE and SW sites over the last 10 years.

WILCOX-TEST: Mean growth is not significant different (p=0.157) between the NE and SW sites over the last 10 years.

*** 

#### Part 2 Answers

**Part 2 Question 1: ** 

E.Coli has *4239* coding sequences. H.Anseris has *1578* CDS. There are approximately 2.7 times more CDS in E.Coli when compared to H.Anseris. 

**Part 2 Question 2: **

*E.Coli* 

total CDS length = 3978528 (3.99 MB)

mean = 939 bp

median = 831 bp


*H.Anseris* 

total CDS length = 1534932 (1.53 MB)

mean = 973 bp

median = 816 bp


The total CDS length is approximately 2.6 times greater in E.Coli when compared to H.Anseris. Despite this, the mean and median length of each is roughly comparable between the two organisms *(Figure 3)*. Additionally, H.Anseris includes a small number of longer CDS (>8000 bp in length), whereas all CDS for E.Coli are less than 8000 bp *(Figure 3)*.

**Part 2 Question 3 (Nucleotide): ** See Figure 4A and Figure 4B in Rmd document. 

The frequency of all nucleotides in greater in E.Coli when compared to H.Anseris *(Figure 4A)*. 
As the total coding sequence length is approximately 2.6 times greater in E.Coli when compared to H.Anseris, this observation was expected.

When normalised to the sum of all nucleotides in each CDS, the proportion of G and C was greater in E.Coli when compared to H.Anseris *(Figure 4B)*. 
Conversley, the proportion of A and T was greater in H.Anseris when compared to E.Coli *(Figure 4B)*.

**Part 2 Question 3 (Amino Acid): ** See Figure 5A and Figure 5 B in Rmd document. 

The frequency of amino acids in H.Anseris is considerably lower in H.Anseris when compared to E.Coli *(Figure 5A)*. As the total CDS is 2.6 times shorter in H.Anseris, this is expected.

When looking at the proportion of amino acids in each organism *(Figure 5B)*, Alanine (A), Glycine (G) and Valine (V) are dominant in E.Coli. A higher proportion of isoleucine (I), Lysine (K), Asparagine (N) and Serine (S) are observed in H.Anseris. 

**Part 2 Question 4: ** See Table 4 and Table 5 in Rmd document. 

To give a  snapshot of codon usage, the 6 codons used more and less frequently than expected (by RSCU) are presented in *Table 4* and *Table 5*. 

Arginine features as three out of the 6 least frequently used codons (AGG, AGA, CGA) *(Table 4)*. 
These all feature adenine, which is the least frequently used nucleotide in the E.Coli cds *(Figure 4A)*.
Arginine also features twice in the 6 most frequently used codons (CGT, CDC) *(Table 4)* As expected, these show a strong GC bias reflective of the high GC content in the E.Coli CDS *(Figure 4B)*.


Codons which feature a high GC content are used less frequently in H.Anseris *(Table 5)*. 
Conversely, codons with a high AT content are among the most frequently used codons in H.Anseris. 
This is as expected, as the H.Anseris features a high proportion of adenine and thymine *(Figure 4B)*
Interestingly, codons for Arginine are among both the most (AGA) and least (CGG) frequently used codons in H.Anseris *(Table 5)*. 

**Part 2 Question 5: **

*3-mers: * All possible amino acid 3-mers are encoded by the E.coli CDS. Under-represented 3-mers show a high proportion of C and W, which constitute the lowest proportion of amino acids in the E.Coli CDS.  
However, there are multiple amino acid 3-mers that are not detected (frequency = 0) in H.Anseris.

LLL is the only amino acid 3-mer present in the over-represented k-mers of both organisms.
The over-represented 3-mers in H.Anseris show a high frequency of K, I and N: a higher proportion of these amino acids is present in H.Anseris when compared to E.Coli *(Figure 5B)*.

*4-mers: * The under-represented amino acid 4-mers all have a zero frequency in both E.Coli and H.Anseris and are ordered in alphabetical order (by amino acid single letter). 
At this resolution, it is not possible to identify similarities or differences between the under-represented amino acid 5-mers between organisms. 

Over-represented amino acid 4-mers in E.Coli exclusively contain A and L. A and L display the highest proportion in E.Coli when compared to all other amino acids *(Figure 5B)*.
Conversely, over-represented amino acid 4-mers for H.Anseris contain combination of K, I, L and N (among some others), all of which display the highest proportion in H.Anseris when compared to all other amino acids *(Figure 5B)*.

*5-mers: * The under-represented amino acid 5-mers all have a zero frequency in both E.Coli and H.Anseris, as described above for the amino acid 4-mers. 

The over-represented amino acid 5-mers are quite different between organisms. 
As with the 3- and 4-mers, L and A are well-represented in the over-represented amino acid 5-mers for E.Coli. 
In addition, combinations of G, K, S and L constitute the 3 most over-represented 5-mers which possibly reflect the high GC content of the E.Coli CDS. 
In contrast, the over-represented amino acid 5-mers for H.Anseris are diverse but contain F, T, S, W, D and L frequently. 

***

End of document

***
