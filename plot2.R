library(ggplot2)
library(dplyr)
# Opening the two rds files

if(!file.exists("./data")){
  dir.create("./data")
}

NEI <- readRDS("/home/coral/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coral/data/Source_Classification_Code.rds")

# 2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510"\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 
# to 2008? Use the base plotting system to make a plot answering this question.

balt <- NEI %>% 
  filter(fips == "24510")

totalbalt <- aggregate(Emissions ~ year, balt, sum)
# Plot 2
plot(totalbalt$year,
     totalbalt$Emissions,
     main = "Total PM 2.5 Emissions in Baltimore by Year",
     xlab = "Year",
     ylab = "Total PM 2.5 Emissions",
     pch = 20
)

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()