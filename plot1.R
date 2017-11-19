####################################################
# Script for Plot 1 generation
####################################################
#Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? Using the base plotting system, make a plot showing 
#the total PM2.5 emission from all sources for each of the years 1999, 2002, 
#2005, and 2008.
####################################################
# Script must be executed in same folder as dataset
# for reading the Data, package sqldf will be used

#load library to agregate data further ahead
library(dplyr)

#check if file exists
summaryRDSFile<-"./summarySCC_PM25.rds"
classificationRDSFile<-"./Source_Classification_Code.rds"
if (!file.exists(summaryRDSFile) | !file.exists(classificationRDSFile)){ 
    stop("Dataset files not present!") 
}

#read data
summaryRDS<-readRDS(summaryRDSFile)
classificationRDS<-readRDS(classificationRDSFile)

#plot
groupPM25<-group_by(summaryRDS,year)
agrSummaryPM25<-summarize(groupPM25,total=sum(Emissions),na.rm=TRUE)
barplot(agrSummaryPM25$total,names.arg = agrSummaryPM25$year, col="red",
        xlab="Year",ylab="Total PM2.5 Emissions", 
        main="Total PM2.5 Emissions per Year - All sources")
abline(h=mean(agrSummaryPM25$total))

#write PNG
dev.copy(png,"plot1.png")
dev.off()




