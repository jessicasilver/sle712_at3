#sle712 at3: draft script
#2022-07-06

#file “gene_expression.tsv”
#1. read in the file, make the gene identifiers the row names. Show a table of values for the first six genes.
#go to URL in AT3.pdf, click on view raw and copy URL

#1. read in file
gene.expression.URL <- "https://raw.githubusercontent.com/markziemann/SLE712_files/master/assessment_task3/bioinfo_asst3_part1_files/gene_expression.tsv"
gene.expression.tsv <- read.table(gene.expression.URL)
gene.expression.tsv
#looking at this, rows have been given new identifiers and columns have been named V1 and V2. Need to make gene identifiers the row names. 
gene.expression.tsv <- read.table(gene.expression.URL, header=TRUE, row.names = 1)
gene.expression.tsv


#1. Show a table of values for the first six genes.
#this will be in the [r,c] format
#question wants row 1:6, all columns.
gene.expression.tsv[1:6,]
#NOTE: in Rmd this will need to be embedded into .html


#2. Make a new column which is the mean of the other columns. Show a table of values for the first six genes.
colMeans(gene.expression.tsv)
#I am not sure this makes sense. Given there are 3 columns, if I do colMeans then this will give me 3 new values (and it did). Should it be rowMeans? 
gene.expression.tsv$CMeans <- colMeans(gene.expression.tsv)
# this returns error code, for exactly what I thought it would do. 
#"> gene.expression.tsv$CMeans <- colMeans(gene.expression.tsv)
    #Error in `$<-.data.frame`(`*tmp*`, CMeans, value = c(GTEX.1117F.0226.SM.5GZZ7 = 859.790302491103,  : 
     #replacement has 3 rows, data has 56200
#Have emailed MZ, but let's try with row means
rowMeans(gene.expression.tsv)
gene.expression.tsv$GE.Means <- rowMeans(gene.expression.tsv)
gene.expression.tsv
#good, have the new column. yay. it's got a lot of sig figures though - perhaps something to modify later? 
#Show a table of values for the first six genes.
gene.expression.tsv[1:6,]
#done. this will need to be embedded into .rmd later

#3. List the 10 genes with the highest mean expression
#will have to subset the data for GE.Means (ncol??), and then reverse sort, and then only show what will then be 1:10? Let's see. 
#will need to use drop=FALSE to keep data in matrix format, not into a vector like rstudio will try to do. 
gene.expression.tsv[,ncol(gene.expression.tsv),drop=FALSE]
#so only showing last column (GE.Means)
#now I want to sort for the genes with highest to lowest GE.Means
sortedGE.Means <- gene.expression.tsv[order(gene.expression.tsv$GE.Means,)]
#this keeps coming up with error code.
#try again... 
order(gene.expression.tsv$GE.Means)
#line 47 works and order GE.Means from lowest to highest. presents as vector not matrix. 
#remove sortedGE.Means
rm(sortedGE.Means)

#okay. looking at GE.Means column, sort
order(gene.expression.tsv$GE.Means)
#this has ordered from lowest to highest. 
sortedGEMeans <- gene.expression.tsv[order(gene.expression.tsv$GE.Means),]
sortedGEMeans
#okay, so this is working. 
#it is showing all columns where GE.Means is sorted from lowest to highest.
#let's now go from highest to lowest.
reverse_sortedGEMeans <- gene.expression.tsv[order(-gene.expression.tsv$GE.Means),]
reverse_sortedGEMeans
#reverse_sortedGEMeans is good. highest to lowest.
#but is still showing all cols.
reverse_sortedGEMeans[1:10,]
#showing top 10 good
#now can I show just the GE.Means col? 
reverse_sortedGEMeans[1:10,4,drop=FALSE]
#YES! yay.
#looking at the genes - are we looking at mito data? Seems to be mt-encoded transcripts in the top 10. Cool. 

#4. Determine the number of genes with a mean <10
#subset first for GE.Means
gene.expression.tsv$GE.Means
#then specify for < 10
gene.expression.tsv$GE.Means < 10
#returns a bunch of true/false.
#so use which function tp pull out <10 = TRUE
which(gene.expression.tsv$GE.Means < 10)
#there's heaps. 
#now i want to ID the row names for which GE.Means<10
gene.expression.tsv[which(gene.expression.tsv$GE.Means <10),]
#works. but is showing all col
gene.expression.tsv[which(gene.expression.tsv$GE.Means <10),4]
#shows as vector. add drop=FALSE to return as data frame
gene.expression.tsv[which(gene.expression.tsv$GE.Means <10),4,drop=FALSE]
#this is fine, but I'm pretty sure there was an easier way to do this???
subset(gene.expression.tsv,GE.Means <10)
#does the same thing, but still show all col. 
#okay so this is fine, but I just re-read the question. it wants the NUMBER of genes with GE.Means<10
nrow(gene.expression.tsv[gene.expression.tsv$GE.Means <10,])
#it works!! n=35988


#5. Make a histogram plot of the mean values and include it into your report.
#first should define GE.Means as data
GE.Means <- gene.expression.tsv$GE.Means
GE.Means
hist(GE.Means,main="Part-1 Q-5: Mean Gene Expression Values")
hist(GE.Means)
#getting a hist but it only has one bin. 
#try changing number of sig figures in data?
GE.Means <- signif(gene.expression.tsv$GE.Means, 3)
GE.Means
hist(GE.Means)
#leave for the mo
#stopped here 2022-07-05, commit to github.