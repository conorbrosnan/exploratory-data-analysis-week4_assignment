## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Get all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

# subset Data for Baltimore City and aggregate by Year and Type for more efficient plotting
aggrTotalByYearCoal<-aggregate(Emissions ~ year, subsetNEISCC, sum)

png('plot4.png')
g <- ggplot(aggrTotalByYearCoal, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from Coal Sources from 1999 to 2008')
print(g)
dev.off()