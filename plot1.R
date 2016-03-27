#Question 1

#set the work directory where the data resides
setwd("C:/Users/bharathi_balaji/R")

#read the data files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

tot.PM25yr <- tapply(NEI$Emissions, NEI$year, sum) 

# Generate the graph in the same directory as the source code
png(filename='plot1.png')

plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", ylab = expression
     ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ 
     PM[2.5] ~ "Emissions by Year"), col="Blue")
dev.off()
