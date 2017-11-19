####################################################
# Script for Plot 3 generation
####################################################
#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four 
#sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting
#system to make a plot answer this question.
####################################################
# Script must be executed in same folder as dataset
# for reading the Data, package sqldf will be used

#load libraries
library(dplyr)
library(ggplot2)

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
groupPM25<-group_by(subsetsummaryRDS,type,year)
agrSummaryPM25<-summarize(groupPM25,total=sum(Emissions),na.rm=TRUE)
pl<-ggplot(agrSummaryPM25,aes(year,total,color=type,
                              xlab="Year",ylab="Total PM2.5 Emissions", 
                              main="Total PM2.5 Emissions per Year for Baltimore City, per Source Type"))
pl+geom_path()

#write PNG
dev.copy(png,"plot3.png")
dev.off()




