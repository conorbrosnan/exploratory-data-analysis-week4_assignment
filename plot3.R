## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# subset Data for Baltimore City and aggregate by Year and Type for more efficient plotting
aggrTotalTypeByYearBalt<-aggregate(Emissions ~ year+type, subset(NEI,fips=="24510"), sum)

png('plot3.png')
g <- ggplot(aggrTotalTypeByYearBalt, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')
print(g)
dev.off()