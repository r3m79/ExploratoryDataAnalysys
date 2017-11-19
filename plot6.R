####################################################
# Script for Plot 6a generation
####################################################
#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). Which city has seen greater changes over 
#time in motor vehicle emissions?
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

#subset data for motor vehicles in Baltimore and LA
#respectively fips=="24510" and fips=="06037"
subsetsummaryRDSBalt<-subset(summaryRDS,fips=="24510" & type == "ON-ROAD")
subsetsummaryRDSLA<-subset(summaryRDS,fips=="06037" & type == "ON-ROAD")

#plot
groupPM25Balt<-group_by(subsetsummaryRDSBalt,type,year)
agrSummaryPM25Balt<-summarize(groupPM25Balt,total=sum(Emissions),na.rm=TRUE)
groupPM25LA<-group_by(subsetsummaryRDSLA,type,year)
agrSummaryPM25LA<-summarize(groupPM25LA,total=sum(Emissions),na.rm=TRUE)
par(mfrow=c(1,2))
rng<-range(agrSummaryPM25Balt$total,agrSummaryPM25LA$total,na.rm = TRUE)
barplot(agrSummaryPM25Balt$total,names.arg = agrSummaryPM25Balt$year, col="blue",
        xlab="Year",ylab="Total PM2.5 Emissions", 
        main="Total PM2.5 for Motor Vehicles in Baltimore",
        ylim=rng)
abline(h=mean(agrSummaryPM25Balt$total))
barplot(agrSummaryPM25LA$total,names.arg = agrSummaryPM25LA$year, col="red",
        xlab="Year",ylab="Total PM2.5 Emissions", 
        main="Total PM2.5 for Motor Vehicles in LA",
        ylim=rng)
abline(h=mean(agrSummaryPM25LA$total))


#write PNG
dev.copy(png,"plot6.png")
dev.off()
