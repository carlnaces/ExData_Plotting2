library(ggplot2)
library(dplyr)
# Opening the two rds files

if(!file.exists("./data")){
  dir.create("./data")
}

NEI <- readRDS("/home/coral/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coral/data/Source_Classification_Code.rds")

# 1 Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the BASE plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# We can use the aggregate function which acts like a group by
# emissions by year
totalEm <- aggregate(Emissions ~ year, NEI, sum)

# Plot 1
plot(totalEm$year,
     totalEm$Emissions,
     main = "Total US PM2.5 Emissions by Year",
     xlab = "Year",
     ylab = "Total PM 2.5 Emissions",
     pch = 20
)

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()