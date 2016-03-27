## Question 6
 
## Libraries needed: 
library(plyr)
library(ggplot2)
library(grid)

## read in the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## check the levels for types of vehicles defined
motorvehicle.sourced <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
motorvehicle.sourcec <- SCC[SCC$EI.Sector %in% motorvehicle.sourced, ]["SCC"]


## subset our data Baltimore City
emissionMotorVehicle.baltimore <- NEI[NEI$SCC %in% motorvehicle.sourcec$SCC & NEI$fips == "24510", ]
## Step 3B: subset our data Los Angeles County
emissionMotorVehicle.LA <- NEI[NEI$SCC %in% motorvehicle.sourcec$SCC & NEI$fips == "06037", ]

## Step 3C: bind the data created
emissionMotorVehicle.comb <- rbind(emissionMotorVehicle.baltimore, emissionMotorVehicle.LA)
  
## Find the emmissions due to motor vehicles in 
## Baltimore (city) and Los Angeles County
tmveYR.county <- aggregate (Emissions ~ fips * year, data =emissionMotorVehicle.comb, FUN = sum ) 
tmveYR.county$county <- ifelse(tmveYR.county$fips == "06037", "Los Angeles", "Baltimore")

## Step 5: plotting to png
png("plot6.png", width=750)
qplot(year, Emissions, data=tmveYR.county, geom="line", color=county) + 
ggtitle(expression("Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  from 1999 to 2008 in Los Angeles County, CA and Baltimore, MD")) +
xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions"))
dev.off()
