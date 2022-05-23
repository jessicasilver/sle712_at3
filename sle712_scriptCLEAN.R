#q1
gene.expression.URL <- "https://raw.githubusercontent.com/markziemann/SLE712_files/master/assessment_task3/bioinfo_asst3_part1_files/gene_expression.tsv"
gene.expression.tsv <- read.table(gene.expression.URL,stringsAsFactors = FALSE, header=TRUE, row.names = 1)

gene.expression.tsv[1:6,]

#q2
gene.expression.tsv$GE.Means <- rowMeans(gene.expression.tsv)
signif(gene.expression.tsv$GE.Means, digits = 3)
#but how to change number of decimals so that it is consistent in all outputs? 

#q3
reverse_sortedGEMeans <- gene.expression.tsv[order(-gene.expression.tsv$GE.Means),]
reverse_sortedGEMeans[1:10,4,drop=FALSE]

#q4
nrow(gene.expression.tsv[gene.expression.tsv$GE.Means <10,])


#q5
hist(gene.expression.tsv$GE.Means,main="Part-1 Q-5: Mean Gene Expression Values",
     xlab="Mean Gene Expression",breaks="scott",xlim=c(0,10000),ylim = c(0,50000))

##various xlim and ylim options
hist(gene.expression.tsv$GE.Means,main="Part-1 Q-5: Mean Gene Expression Values",
     xlab="Mean Gene Expression",breaks="scott",xlim=c(200,100000),ylim = c(0,1000))

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

lapply(X=bothsites, FUN = GDmeansd)

#q8
boxplot(NEsite$Circumf_2005_cm,  SWsite$Circumf_2005_cm, NEsite$Circumf_2020_cm, SWsite$Circumf_2020_cm,names=c("Northeast 2005", 
                "Southwest 2005", "Northeast 2020", "Southwest 2020"), ylab="Tree Circumference (cm)",ylim=c(0,120))
grid()
#include figure legend below in rmd document

#q9
mean10year <- function (x,y) { 
  growth10 <- x - y 
  mean10 <- mean(growth10)
  paste("The mean growth over the past ten years was", mean10 , "cm")
}

mean10year(NEsite$Circumf_2020_cm,NEsite$Circumf_2010_cm)
mean10year(SWsite$Circumf_2020_cm,SWsite$Circumf_2010_cm)

#q10



NEsite10 <- mean10year(NEsite$Circumf_2020_cm,NEsite$Circumf_2010_cm)
SWsite10 <- mean10year(SWsite$Circumf_2020_cm,SWsite$Circumf_2010_cm)

NEsite10


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






