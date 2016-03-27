##Question 3

##Set the work directory
setwd("C:\Users\bharathi_balaji\R")
 
## Libraries needed:
library(ggplot2)
library(plyr)

##read in the data file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##  subset our data for Baltimore
baltimore <- subset (NEI, fips == "24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

## Rename the col: Emissions
colnames(typePM25.year)[3] <- "Emissions"

## repare to plot to png
png("plot3.png") 
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + 
ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by source, type and year")) +
xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
dev.off()
