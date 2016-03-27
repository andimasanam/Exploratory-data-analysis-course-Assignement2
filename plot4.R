## Question 4

## Libraries needed:
library(plyr)
library(ggplot2)

## Set the work directory
setwd("C:\Users\bharathi_balaji\R")

## read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset our data for only coal-combustion
coalcomb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
  "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
  Coal"))

## comparisons so that we didn't ommit anything weird
coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

##Union
coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)

##Subset
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

## get the PM25 values as well
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

#rename the col
colnames(coalcomb.pm25year)[3] <- "Emissions"

##prepare to plot to png
png("plot4.png")

qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + 
stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "blue", aes(shape="total"), geom="line") +
geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Type and Year")) + 
xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.off()
