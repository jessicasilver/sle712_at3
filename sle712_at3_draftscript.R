#sle712 at3: draft script
#2022-05-07

#file “gene_expression.tsv”
#1. read in the file, make the gene identifiers the row names. Show a table of values for the first six genes.
#go to URL in AT3.pdf, click on view raw and copy URL

#1. read in file
gene.expression.URL <- "https://raw.githubusercontent.com/markziemann/SLE712_files/master/assessment_task3/bioinfo_asst3_part1_files/gene_expression.tsv"
gene.expression.tsv <- read.table(gene.expression.URL)
gene.expression.tsv
#looking at this, rows have been given new identifiers and columns have been named V1 and V2. Need to make gene identifiers the row names. 
gene.expression.tsv <- read.table(gene.expression.URL,stringsAsFactors = FALSE, header=TRUE, row.names = 1)
gene.expression.tsv
str(gene.expression.tsv)

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
#You can turn it off with options(scipen = 999) and back on again with options(scipen = 0)
#https://stackoverflow.com/questions/25946047/how-to-prevent-scientific-notation-in-r
options(scipen = 999)
gene.expression.tsv
#this removed e notation (scientific)
#still have lots of decimals. 

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
#works and order GE.Means from lowest to highest. presents as vector not matrix. 
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
#leave for the mo
#stopped here 2022-05-07, commit to github.
#trying on 2022-05-09
hist(gene.expression.tsv$GE.Means,main="Part-1 Q-5: Mean Gene Expression Values")
#still one bin. Okay.
hist(gene.expression.tsv$GE.Means,main="Part-1 Q-5: Mean Gene Expression Values", xlab="Mean Gene Expression",breaks="scott",xlim=c(0,10000),ylim = c(0,50000))
#function above. breaks = change bin number and size
#must be one of “sturges”, “fd”, “freedman-diaconis”, “scott”


#2022-05-07
#looking again at hist. Is it only giving 1  bin because there are so many zero values? 
#code from stackoverflow
#https://stackoverflow.com/questions/9977686/how-to-remove-rows-with-any-zero-value
GE.Means.nozeros <- GE.Means[GE.Means==0.00]
GE.Means.nozeros
hist(GE.Means.nozeros)
rm(GE.Means.nozeros)
##nope. this doesn't work. How can I remove 0 values?


#2022-05-09
#reply from MZ: q2 is definitely about columns. 
#2. Make a new column which is the mean of the other columns. Show a table of values for the first six genes.
colMeans(gene.expression.tsv)
gene.expression.tsv
# Am i overthinking this? MZ reply: 
#"No the question is definitely about columns.
#In transcriptome analysis, sometimes we calculate the column means for control and case groups separately
#so that we can calculate a fold change or effect size for individual genes."
#yep. Just overthinking this. Keep as is with rowMeans


max(GE.Means)


#2022-05-10
#part 2
#1. import this file into an R object.
growth.data.URL <- "https://raw.githubusercontent.com/markziemann/SLE712_files/master/assessment_task3/bioinfo_asst3_part1_files/growth_data.csv"
growth.data.csv <- read.table(growth.data.URL,sep = ",",  header=TRUE)
growth.data.csv
#row names have been given numbers, column names have been identified as V1 V2 etc
str(growth.data.csv)
#this is better but it still have row name as integers. 

#looking at notes, i should just be able to use the read.csv function instead of read.table? try...
growth.data.csv <- read.csv(growth.data.URL)
growth.data.csv
?read.csv
#this is fine. 

#1. what are the column names? 
colnames(growth.data.csv)
#"Site"            "TreeID"          "Circumf_2005_cm" "Circumf_2010_cm" "Circumf_2015_cm" "Circumf_2020_cm"

#2. Calculate the mean and SD of tree circumference at th start and end of the study at both sites. 
#okay so we have two sites "northeast" and "southwest" 
#start of study is col3: circumf_2005_cm
#end of study is col6: circum_2020_cm
head(growth.data.csv)
?head
northeast.site <- subset(growth.data.csv,Site == "northeast")
head(northeast.site)
#i have now subsetted growth.data.csv for northeast site: df=northeast.site
mean(northeast.site$Circumf_2005_cm)
sd(northeast.site$Circumf_2005_cm)
#start of study: mean=5.292 sd=0.914
#change sig figs? 
mean(northeast.site$Circumf_2020_cm)
sd(northeast.site$Circumf_2020_cm)
#end of study: mean=54.228 sd=25.22795
#change sig figures?

#now subset for southwest site, and calc mean and sd at start and end of study
southwest.site <- subset(growth.data.csv,Site == "southwest")
head(southwest.site)
mean(southwest.site$Circumf_2005_cm)
sd(southwest.site$Circumf_2005_cm)
#start of study: mean=4.862 sd=1.147471
mean(southwest.site$Circumf_2020_cm)
sd(southwest.site$Circumf_2020_cm)
#end of study: mean=45.596 sd=17.87345

#3. Make a box plot of tree circumference at the start and end of the study at both sites.
?boxplot
boxplot(northeast.site$Circumf_2005_cm, northeast.site$Circumf_2020_cm)
#this base function works: can I also add southwest site to the same boxplot? 
boxplot(northeast.site$Circumf_2005_cm, northeast.site$Circumf_2020_cm, southwest.site$Circumf_2005_cm, southwest.site$Circumf_2020_cm)
#yep.
#need y lab
boxplot(northeast.site$Circumf_2005_cm, northeast.site$Circumf_2020_cm, southwest.site$Circumf_2005_cm, southwest.site$Circumf_2020_cm,ylab="Tree Circumference (cm)")
#need x lab
boxplot(northeast.site$Circumf_2005_cm, northeast.site$Circumf_2020_cm, southwest.site$Circumf_2005_cm, southwest.site$Circumf_2020_cm,names=c("Northeast 2005", "Northeast 2020", "Southwest 2005", "Southwest 2020"),ylab="Tree Circumference (cm)")
#zoom in to see labels on all plots
#let's change order of data. 
boxplot(northeast.site$Circumf_2005_cm,  southwest.site$Circumf_2005_cm, northeast.site$Circumf_2020_cm, southwest.site$Circumf_2020_cm,names=c("Northeast 2005", "Southwest 2005", "Northeast 2020", "Southwest 2020"),ylab="Tree Circumference (cm)")


#2022-05-13
#Calculate the mean growth over the last 10 years at each site.
#mean $Circum_2015_cm and $Circumf_2020_cm for both northeast.site and southwest.site
mean(northeast.site$Circumf_2015_cm,northeast.site$Circumf_2020_cm)
#doesn't work. Do I need to subset this data further? 
northeast.site[,c("Circumf_2015_cm","Circumf_2020_cm")]
northeast.last10 <- northeast.site[,c("Circumf_2015_cm","Circumf_2020_cm")]
head(northeast.last10)
southwest.site[,c("Circumf_2015_cm","Circumf_2020_cm")]
southwest.last10 <- southwest.site[,c("Circumf_2015_cm","Circumf_2020_cm")]
head(southwest.last10)
#so I have further subsetted the northeast and southwest sites into the last 10 years
#now I want to get the mean 
#can I add a new col which is the mean of the last 10 years? 
northeast.last10$Tenyear.Mean <- rowMeans(northeast.last10)
head(northeast.last10)
#that works. So now do the same for southwest?
southwest.last10$Tenyear.Mean <- rowMeans(southwest.last10)
head(southwest.last10)
#but q wants mean OVERALL growth i.e. of all trees? 
colMeans(northeast.last10)
colMeans(southwest.last10)
#ten year mean NE=39.372
#ten year mean SW=33.456
#this is a messy and long way of doing it. Is there a more succinct way? 

#q5. Use the t.test and wilcox.test functions to estimate the p-value that the 10 year 
#growth is different at the two sites.
#2022-05-14
northeast10 <- northeast.last10$Tenyear.Mean
northeast10
southwest10 <- southwest.last10$Tenyear.Mean
southwest10

ttest10year <- t.test(northeast10,southwest10)
ttest10year$p.value
signif(ttest10year$p.value,3)
ttest.result <- signif(ttest10year$p.value,3)
ttest.result
#p=0.0465, p<0.05 and growth is sig different. 
if (ttest.result < 0.05) {
  message("Mean growth is significantly different (p=", ttest.result, ") between the NE and SW sites over the last 10 years.")
} else {
  message("Mean growth is NOT significantly different (p=", ttest.result, ")between the NE and SW sites over the last 10 years.")
}

?wilcox.test


#Some suggestions from Greg: 
#use grep function for subsetting NE and SW data. 
#head(growth.data.csv)
#col n=3 etc = NULL
#does last 10 years of data mean 2010-2020, or 2015-2020?
#https://www.r-bloggers.com/2013/06/box-plot-with-r-tutorial/ 
#for later. 

#2022-05-14
#redo growthdata with `grep` and `function`
#subset growth data using grep function
growth.data.csv

growth.data.csv[grep("northeast", growth.data.csv$Site), ]
NEsite <- growth.data.csv[grep("northeast", growth.data.csv$Site), ]
NEsite

SWsite <- growth.data.csv[grep("southwest", growth.data.csv$Site), ]
SWsite

nrow(SWsite)
nrow(NEsite)


mean(NEsite$Circumf_2005_cm)
sd(NEsite$Circumf_2005_cm)
mean(NEsite$Circumf_2020_cm)
sd(NEsite$Circumf_2020_cm)

mean(SWsite$Circumf_2005_cm)
sd(SWsite$Circumf_2005_cm)
mean(SWsite$Circumf_2020_cm)
sd(SWsite$Circumf_2020_cm)

GDmeansd <- function (x) {
  GDmean <- signif(mean(x),3)
  GDsd <- signif(sd(x),3)
  message("Mean = ", GDmean , " SD = ", GDsd)
}

GDmeansd(NEsite$Circumf_2005_cm)
GDmeansd(NEsite$Circumf_2020_cm)
GDmeansd(SWsite$Circumf_2005_cm)
GDmeansd(SWsite$Circumf_2020_cm)

boxplot(NEsite$Circumf_2005_cm,  SWsite$Circumf_2005_cm, 
        NEsite$Circumf_2020_cm, SWsite$Circumf_2020_cm,
        names=c("Northeast 2005", "Southwest 2005", "Northeast 2020", "Southwest 2020"),
        ylab="Tree Circumference (cm)")

#2022-05-16
#try using `lapply` or `sapply` fpr GDmeans 
#put each of the subsets in a list
sitelist <- list(NEsite_2005 = NEsite$Circumf_2005_cm, NEsite_2020 = NEsite$Circumf_2020_cm, 
                 SWsite_2005 = SWsite$Circumf_2005_cm, SWsite_2020 = SWsite$Circumf_2020_cm)
sitelist

sapply(X = sitelist, FUN = GDmeansd)
#this is working and returning mean and SD values but also some NULL lines. 
