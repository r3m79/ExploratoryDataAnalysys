####################################################
# Script for Plot 5 generation
####################################################
#How have emissions from motor vehicle sources changed 
#from 1999-2008 in Baltimore City?
####################################################
# Script must be executed in same folder as dataset
# for reading the Data, package sqldf will be used

#load libraries
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

#subset data for Bailtimore (fips=="24510") and motor vehicles
subsetsummaryRDS<-subset(summaryRDS,fips=="24510" & type == "ON-ROAD")

#plot
groupPM25<-group_by(subsetsummaryRDS,type,year)
agrSummaryPM25<-summarize(groupPM25,total=sum(Emissions),na.rm=TRUE)
barplot(agrSummaryPM25$total,names.arg = agrSummaryPM25$year, col="red",
        xlab="Year",ylab="Total PM2.5 Emissions", 
        main="Total PM2.5 Emissions for Motor Vehicles in Baltimore")
abline(h=mean(agrSummaryPM25$total))


#write PNG
dev.copy(png,"plot5.png")
dev.off()




