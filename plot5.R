## Question 5

## Libraries needed:
library(plyr)
library(ggplot2)

## read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset our data 
motorvehicle.sourced <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
motorvehicle.sourcec <- SCC[SCC$EI.Sector %in% motorvehicle.sourced, ]["SCC"]

##subset the emissions from motor vehicles
##NEI for Baltimore, MD.
EmissionMotorVehicle.baltimore <- NEI[NEI$SCC %in% motorvehicle.sourcec$SCC & NEI$fips == "24510",]

## find the emissions due to motor vehicles in Baltimore for every year
balmv.pm25yr <- ddply(EmissionMotorVehicle.baltimore, .(year), function(x) sum(x$Emissions))
colnames(balmv.pm25yr)[2] <- "Emissions"

## Step 4: Plot to png
png("plot5.png")
qplot(year, Emissions, data=balmv.pm25yr, geom="line") + 
ggtitle(expression("Baltimore" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + 
xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
