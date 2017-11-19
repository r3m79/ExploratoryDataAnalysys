####################################################
# Script for Plot 4 generation
####################################################
#Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999-2008?
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

#subset data for Coal Combustion sources
coalClassificationRDS<-classificationRDS[grep("Coal",levels(classificationRDS$EI.Sector)),]
subsetsummaryRDS<-summaryRDS[summaryRDS$SCC %in% coalClassificationRDS$SCC,]

#plot
groupPM25<-group_by(subsetsummaryRDS,year)
agrSummaryPM25<-summarize(groupPM25,total=sum(Emissions),na.rm=TRUE)
barplot(agrSummaryPM25$total,names.arg = agrSummaryPM25$year, col="red",
        xlab="Year",ylab="Total PM2.5 Emissions", 
        main="Total PM2.5 Emissions per Year for Coal Combustion Sources")
abline(h=mean(agrSummaryPM25$total))

#write PNG
dev.copy(png,"plot4.png")
dev.off()
