## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# subset Data for Baltimore City and aggregate for more efficient plotting
aggrTotalByYearBalt<-aggregate(Emissions ~ year, subset(NEI,fips=="24510"), sum)

png('plot2.png')
barplot(height=aggrTotalByYearBalt$Emissions, names.arg=aggrTotalByYearBalt$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions in Baltimore City at various years'))
dev.off()