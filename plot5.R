## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

#Filter SCC for OnRoad Sources 
OnRoadSCC=subset(SCC,Data.Category=="Onroad")

# merge the two data sets for OnRoad Sources only 
NEISCC <- merge(NEI, OnRoadSCC, by="SCC")

library(ggplot2)

# subset Data for Baltimore City and aggregate by Year for more efficient plotting
aggrTotalByYearOnRoadBalt<-aggregate(Emissions ~ year, subset(NEISCC,fips=="24510"), sum)

png('plot5.png')
g <- ggplot(aggrTotalByYearOnRoadBalt, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from OnRoad Sources for Baltimore City from 1999 to 2008')
print(g)
dev.off()