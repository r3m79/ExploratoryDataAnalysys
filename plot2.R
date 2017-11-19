####################################################
# Script for Plot 2 generation
####################################################
#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
#to make a plot answering this question.
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

#subset data for Bailtimore (fips=="24510")
subsetsummaryRDS<-subset(summaryRDS,fips=="24510")

#plot
groupPM25<-group_by(subsetsummaryRDS,year)
agrSummaryPM25<-summarize(groupPM25,total=sum(Emissions),na.rm=TRUE)
barplot(agrSummaryPM25$total,names.arg = agrSummaryPM25$year, col="red",
        xlab="Year",ylab="Total PM2.5 Emissions", 
        main="Total PM2.5 Emissions per Year for Baltimore City")
abline(h=mean(agrSummaryPM25$total))

#write PNG
dev.copy(png,"plot2.png")
dev.off()




