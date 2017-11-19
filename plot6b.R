####################################################
# Script for Plot 6b generation
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
library(ggplot2)
library(stringr)

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
subsetsummaryRDS<-subset(summaryRDS, fips %in% c("24510","06037") & type == "ON-ROAD")

#plot
groupPM25<-group_by(subsetsummaryRDS,fips,year)
agrSummaryPM25<-summarize(groupPM25,total=sum(Emissions),na.rm=TRUE)
Location <- str_replace_all(agrSummaryPM25$fips, c("06037" = "LA County", "24510" = "Baltimore City")) 
pl<-ggplot(agrSummaryPM25,aes(year,total,
                              xlab="Year",ylab="Total PM2.5 Emissions", 
                              main="Total PM2.5 Emissions per Year for motor Vehicles",
                              fill=Location))
pl+geom_bar(stat = "identity", position = "dodge")
#par(mfrow=c(1,2))
#rng<-range(agrSummaryPM25Balt$total,agrSummaryPM25LA$total,na.rm = TRUE)


#write PNG
dev.copy(png,"plot6b.png")
dev.off()
