#q1
gene.expression.URL <- "https://raw.githubusercontent.com/markziemann/SLE712_files/master/assessment_task3/bioinfo_asst3_part1_files/gene_expression.tsv"
gene.expression.tsv <- read.table(gene.expression.URL,stringsAsFactors = FALSE, header=TRUE, row.names = 1)

gene.expression.tsv[1:6,]

gene.expression.tsv[1:6,] %>%
  kbl(caption = "Table 1. Part 1 Question 1: Gene Expression dataset showing values for the first six genes") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 12) 

#q2
gene.expression.tsv$GE.Means <- rowMeans(gene.expression.tsv)
gene.expression.tsv <- round(gene.expression.tsv, digits = 0)

gene.expression.tsv[1:6,] %>%
  kbl(caption = "Table 2. Part 1 Question 2: Gene Expression dataset showing values for the first six genes in each sample, and the mean expression across all samples.") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 12) 


#q3
reverse_sortedGEMeans <- gene.expression.tsv[order(-gene.expression.tsv$GE.Means),]
reverse_sortedGEMeans[1:10,4,drop=FALSE]

reverse_sortedGEMeans[1:10,4,drop=FALSE] %>%
  kbl(caption = "Table 3. Part 1 Question 3: Gene Expression dataset showing the 10 genes with the highest mean expression across the three samples.") %>%
  kable_classic(full_width = T, html_font = "Cambria", position = "center", font_size = 12) 

#q4
nrow(gene.expression.tsv[gene.expression.tsv$GE.Means <10,])


#q5
hist(gene.expression.tsv$GE.Means,main="Part-1 Q-5: Mean Gene Expression Values",
     xlab="Mean Gene Expression",breaks="scott",xlim=c(0,10000),ylim = c(0,50000))

##various xlim and ylim options
hist(gene.expression.tsv$GE.Means,main="Part-1 Q-5: Mean Gene Expression Values",
     xlab="Mean Gene Expression",breaks="scott",xlim=c(200,100000),ylim = c(0,1000))

hist(gene.expression.tsv$GE.Means,main="Part-1 Q-5: Mean Gene Expression Values",
     xlab="Mean Gene Expression",breaks="scott",xlim=c(200,600000),ylim = c(0,100))

hist(gene.expression.tsv$GE.Means,main="Part-1 Q-5: Mean Gene Expression Values (truncated)", 
     xlab="Mean Gene Expression",breaks="scott",xlim=c(2000,600000),ylim = c(0,100))

#q6
growth.data.URL <- "https://raw.githubusercontent.com/markziemann/SLE712_files/master/assessment_task3/bioinfo_asst3_part1_files/growth_data.csv"
growth.data.csv <- read.csv(growth.data.URL)
colnames(growth.data.csv)

#q7
NEsite <- growth.data.csv[grep("northeast", growth.data.csv$Site), ]
SWsite <- growth.data.csv[grep("southwest", growth.data.csv$Site), ]

bothsites <- list(NEsite$Circumf_2005_cm,NEsite$Circumf_2020_cm,SWsite$Circumf_2005_cm,SWsite$Circumf_2020_cm)
names(bothsites) <- c("NEsite_2005", "NEsite_2020", "SWsite_2005", "SWsite_2020")

GDmeansd <- function (x) {
  GDmean <- signif(mean(x),3)
  GDsd <- signif(sd(x),3)
  paste("Mean = ", GDmean , " SD = ", GDsd)
}


#q8
boxplot(NEsite$Circumf_2005_cm,  SWsite$Circumf_2005_cm, NEsite$Circumf_2020_cm, SWsite$Circumf_2020_cm,names=c("Northeast 2005", 
                "Southwest 2005", "Northeast 2020", "Southwest 2020"), ylab="Tree Circumference (cm)",ylim=c(0,120))
grid()
#include figure legend below in rmd document

#q9
mean10year <- function (x,y) { 
  growth10 <- x - y 
  mean10 <- mean(growth10)
  paste("The mean growth over the past ten years was",mean10, "cm")
}

mean10year(NEsite$Circumf_2020_cm,NEsite$Circumf_2010_cm)
mean10year(SWsite$Circumf_2020_cm,SWsite$Circumf_2010_cm)

#q10
NEgrowth <- NEsite$Circumf_2020_cm - NEsite$Circumf_2010_cm
SWgrowth <- SWsite$Circumf_2020_cm - SWsite$Circumf_2010_cm
  
ttest10year <- t.test(NEgrowth,SWgrowth)

print(signif(ttest10year$p.value,3))

if (ttest10year$p.value < 0.05) {
  message("Mean growth is significantly different (p=", signif(ttest10year$p.value,3), ") between the NE and SW sites over the last 10 years.")
} else {
  message("Mean growth is not significantly different (p>0.05) between the NE and SW sites over the last 10 years.")
}

wilcox10year <- wilcox.test(NEgrowth,SWgrowth)
print(signif(wilcox10year$p.value,3))
if (wilcox10year$p.value < 0.05) {
  message("Mean growth is significantly different (p=", signif(ttest10year$p.value,3), ") between the NE and SW sites over the last 10 years.")
} else {
  message("Mean growth is not significantly different (p>0.05) between the NE and SW sites over the last 10 years.")
}

#part 2
#q1

ecoliK12URL="http://ftp.ensemblgenomes.org/pub/bacteria/release-53/fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655_gca_000005845/cds/Escherichia_coli_str_k_12_substr_mg1655_gca_000005845.ASM584v2.cds.all.fa.gz"
download.file(ecoliK12URL,destfile = "ecoli_cds.fa.gz")
gunzip("ecoli_cds.fa.gz")

hanserisURL="http://ftp.ensemblgenomes.org/pub/bacteria/release-53/fasta/bacteria_51_collection/helicobacter_anseris_gca_003364335/cds/Helicobacter_anseris_gca_003364335.ASM336433v1.cds.all.fa.gz"
download.file(hanserisURL,destfile = "hanseris_cds.fa.gz")
gunzip("hanseris_cds.fa.gz")


ecoli_cds <- seqinr::read.fasta("ecoli_cds.fa")
length(ecoli_cds)   

hanseris_cds <- seqinr::read.fasta("hanseris_cds.fa")
length(hanseris_cds)


#q1 PART THREE???? 

#q2 (new code - succint)

ecoli_cdslength <- sapply(X = ecoli_cds , FUN=length)
sum(ecoli_cdslength)

hanseris_cdslength <- sapply(X = hanseris_cds , FUN=length)
sum(hanseris_cdslength)

mean(ecoli_cdslength)
median(ecoli_cdslength)

mean(hanseris_cdslength)
median(hanseris_cdslength)

boxplot(ecoli_cdslength,hanseris_cdslength,
        names=c("E.Coli K-12 (GCA_000005845)", "H.Anseris (GCA_003364335)"),
        ylab="Coding Sequence Length (bp)")
grid()


#q2 OLD CODE (long way)
#The basic function `sum` was modified to calculate the length of all coding sequences in each organisms. 
#`sum` will work on vectors but not strings. 
#`head(summary(listname))` shows that the data in ecoli_cds and hanseris_cds is presented as character string. This first needs to be converted to a vector using `as.numeric`, focusing on the the length column `[,1]`
#The length of each element in the list is saved as a new object (i.e. "ecolilength"). 
#Tot length of all CDS in each organism was then calculated using `sum()`
#`mean()` and `median()` functions were executed to calculate the mean and median coding sequence length in each organism. 
#`boxplot()` was modified to include the CDS length data from each organism in the figure. Names were given to each box and a y-axis label was added.

rm(hanserislength)
ecolilength <- as.numeric(summary(ecoli_cds)[,1])
sum(ecolilength)

hanserislength <- as.numeric(summary(hanseris_cds)[,1])
sum(hanserislength)

mean(ecolilength)
median(ecolilength)

mean(hanserislength)
median(hanserislength)

boxplot(ecolilength,hanserislength,
        names=c("E.Coli K-12 (GCA_000005845)", "H.Anseris (GCA_003364335)"),
        ylab="Coding Sequence Length (bp)")
grid()


#q3a frequency of DNA bases in the total coding sequences

ecoli_dna <- unlist(ecoli_cds)
hanseris_dna <- unlist(hanseris_cds)

ecoli_ntfreq <- count(ecoli_dna,1)
hanseris_ntfreq <- count(hanseris_dna,1)

barplot(as.matrix(rbind(ecoli_ntfreq, hanseris_ntfreq)), beside=TRUE, ylab="frequency", ylim = c(0,1200000), xlab = "nucleotide", main = "E. Coli vs H.Anseris CDS composition",col = c("#009999","#FF9933")) #as.matrix and rbind to include both datasets on the one graph
legend("topright", 
       legend = c("E.Coli", "H.Anseris"), 
       fill = c("#009999","#FF9933")) 
grid()
options(scipen = 999)

#q3b
ecoli_prot <- lapply(ecoli_cds,translate)
hanseris_prot <- lapply(hanseris_cds,translate)

aminoacids <- unique(ecoli_prot[[2]])
aminoacids <- aminoacids[aminoacids != "*"]

ecoli_prots <- unlist(ecoli_prot)
hanseris_prots <- unlist(hanseris_prot)

ecoli_protscounts <- count(ecoli_prots,wordsize = 1, alphabet = aminoacids)
ecoli_protscounts
hanseris_protscounts <- count(hanseris_prots,wordsize = 1, alphabet = aminoacids)
hanseris_protscounts

barplot(as.matrix(rbind(ecoli_protscounts, hanseris_protscounts)), beside=TRUE, ylab="frequency", 
        xlab = "amino acid", main = "E. Coli vs H.Anseris protein composition by amino acid",col=c("#006666", "#990000"))
legend("topright", 
       legend = c("E.Coli", "H.Anseri"), 
       fill = c("#006666", "#990000"))
grid()

ecoli_protsprop <- ecoli_protscounts/sum(ecoli_protscounts)
hanseris_protsprop <- hanseris_protscounts/sum(hanseris_protscounts)

barplot(as.matrix(rbind(ecoli_protsprop, hanseris_protsprop)), beside=TRUE, ylab="proportion", 
        xlab = "amino acid", main = "E. Coli vs H.Anseris protein composition by amino acid",ylim = c(0,0.12),col=c("#006666", "#990000"))
legend("topright", 
       legend = c("E.Coli", "H.Anseris"), 
       fill = c("#006666", "#990000"))
grid()


#q4 codon usage
ecoli_uco <- uco(ecoli_dna,index = "rscu",as.data.frame = TRUE)
ecoli_uco_ordered <- ecoli_uco[order(ecoli_uco$RSCU),]  

hanseris_uco <- uco(hanseris_dna,index = "rscu",as.data.frame = TRUE)
hanseris_uco_ordered <- hanseris_uco[order(hanseris_uco$RSCU),]  

ecoli_uco_ordered[c(1:6,59:64),c(1,2,5)] %>% 
  kbl(caption = "Table X. Part 2 Question 4: Top six codons used least frequently (teal shading) and top six codons used more frequently (white) than expected (by RSCU).") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 14) %>%
  row_spec(1:6, color = "white", background = "#006666") %>%
  row_spec(7:12, color = "#009999", background = "White" )

hanseris_uco_ordered[c(1:6,59:64),c(1,2,5)] %>% 
  kbl(caption = "Table X. Part 2 Question 4: Top six codons used least frequently (red) and top six codons used more frequently (white) than expected (by RSCU).") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 14) %>%
  row_spec(1:6, color = "white", background = "#FF9933") %>% 
  row_spec(7:12, color = "#FF9933", background = "White" )


hanseris_uco_ordered[c(1:6,59:64),c(1,2,5)]




ecoli_uco_ordered[,c(1,2,4)] %>% 
  kbl(caption = "Table 3. Part 1 Question 3: Gene Expression dataset showing the 10 genes with the highest mean expression across the three samples.") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 12) 


#q5
ecoli_3merfreq <- count(ecoli_prots,wordsize=3,alphabet=aminoacids,freq=TRUE) #3-mer amino acid sequence by frequency
ecoli_3merfreq_ordered <- ecoli_3merfreq[order(ecoli_3merfreq)] #order, lowest to highest as default

ecoli_4merfreq <- count(ecoli_prots,wordsize=4,alphabet=aminoacids,freq=TRUE) #4-mer amino acid sequence by frequency
ecoli_4merfreq_ordered <- ecoli_4merfreq[order(ecoli_4merfreq)] #order, lowest to highest as default

ecoli_5merfreq <- count(ecoli_prots,wordsize=5,alphabet=aminoacids,freq=TRUE) #4-mer amino acid sequence by frequency
ecoli_5merfreq_ordered <- ecoli_5merfreq[order(ecoli_5merfreq)] #order, lowest to highest as default

#pipe 1:10 (10 underrep) and last 10 (use nrow to determine max row) to kableExtra to present
ecoli_3merfreq_ordered[c(1:10,7991:8000)] %>% 
  kbl(caption = "Table 6. Part 2 Question 5: E.Coli. 10 under-represented (teal shading) over-represented (white) amino acid 3-mers") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 14) %>%
  row_spec(1:10, color = "white", background = "#006666") %>% #shading to distinguish between 10 over and under- rep
  row_spec(11:20, color = "#009999", background = "White" )

ecoli_4merfreq_ordered[c(1:10,159991:160000)] %>% #1:6 lowest 6 by RSCU #59:64 top 6 by RSCU  #pipe to kableExtra
  kbl(caption = "Table 6. Part 2 Question 5: E.Coli. 10 under-represented (teal shading) over-represented (white) amino acid 4-mers") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 14) %>%
  row_spec(1:10, color = "white", background = "#006666") %>% 
  row_spec(11:20, color = "#009999", background = "White" )

ecoli_5merfreq_ordered[c(1:10,3199991:3200000)] %>% 
  kbl(caption = "Table 6. Part 2 Question 5: E.Coli. 10 under-represented (teal shading) over-represented (white) amino acid 5-mers") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 14) %>%
  row_spec(1:10, color = "white", background = "#006666") %>% 
  row_spec(11:20, color = "#009999", background = "White" )

#now for H.Anseris

hanseris_3merfreq <- count(hanseris_prots,wordsize=3,alphabet=aminoacids,freq=TRUE)
hanseris_3merfreq_ordered <- hanseris_3merfreq[order(hanseris_3merfreq)] 

hanseris_4merfreq <- count(hanseris_prots,wordsize=4,alphabet=aminoacids,freq=TRUE)
hanseris_4merfreq_ordered <- hanseris_4merfreq[order(hanseris_4merfreq)] 

hanseris_5merfreq <- count(hanseris_prots,wordsize=5,alphabet=aminoacids,freq=TRUE) 
hanseris_5merfreq_ordered <- hanseris_5merfreq[order(hanseris_5merfreq)] 

#pipe 1:10 (10 underrep) and last 10 (use nrow to determine max row) to kableExtra to present
hanseris_3merfreq_ordered[c(1:10,7991:8000)] %>% 
  kbl(caption = "Table 6. Part 2 Question 5: H.Anseris. 10 under-represented (teal shading) over-represented (white) amino acid 3-mers") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 14) %>%
  row_spec(1:10, color = "white", background = "#006666") %>% #shading to distinguish between 10 over and under- rep
  row_spec(11:20, color = "#009999", background = "White" )

hanseris_4merfreq_ordered[c(1:10,159991:160000)] %>% #1:6 lowest 6 by RSCU #59:64 top 6 by RSCU  #pipe to kableExtra
  kbl(caption = "Table 6. Part 2 Question 5: H.Anseris. 10 under-represented (teal shading) over-represented (white) amino acid 4-mers") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 14) %>%
  row_spec(1:10, color = "white", background = "#006666") %>% 
  row_spec(11:20, color = "#009999", background = "White" )

hanseris_5merfreq_ordered[c(1:10,3199991:3200000)] %>% 
  kbl(caption = "Table 6. Part 2 Question 5: H.Anseris. 10 under-represented (teal shading) over-represented (white) amino acid 5-mers") %>%
  kable_classic(full_width = F, html_font = "Cambria", position = "center", font_size = 14) %>%
  row_spec(1:10, color = "white", background = "#006666") %>% 
  row_spec(11:20, color = "#009999", background = "White" )
