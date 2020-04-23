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

# subset Data for Baltimore City and LA, and aggregate by Year for more efficient plotting
aggrTotalByYearOnRoadBaltLA<-aggregate(Emissions ~ year+fips, subset(NEISCC,fips=="24510"|fips=="06037"), sum)
aggrTotalByYearOnRoadBaltLA$fips[aggrTotalByYearOnRoadBaltLA$fips=="24510"] <- "Baltimore, MD"
aggrTotalByYearOnRoadBaltLA$fips[aggrTotalByYearOnRoadBaltLA$fips=="06037"] <- "Los Angeles, CA"

png('plot6.png', width=1040, height=480)

g <- ggplot(aggrTotalByYearOnRoadBaltLA, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from OnRoad Sources for Baltimore City and Los Angeles from 1999 to 2008')
print(g)
dev.off()