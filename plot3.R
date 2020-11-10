library(ggplot2)
library(dplyr)
# Opening the two rds files

if(!file.exists("./data")){
  dir.create("./data")
}

NEI <- readRDS("/home/coral/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coral/data/Source_Classification_Code.rds")

# 3 Of the four types of sources indicated by the (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 
#1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the GGPLOT2 plotting system to make a plot answer this question.

balt <- NEI %>% 
  filter(fips == "24510")
# unique(balt$type)
# [1] "POINT"    "NONPOINT" "ON-ROAD"  "NON-ROAD"

totalbalttype <- aggregate(Emissions ~ year + type, balt, sum )

ggplot(totalbalttype, aes(year, Emissions, col = type)) +
  geom_point() +
  geom_line() +
  ggtitle("Total Baltimore PM 2.5 Emisions by type", ) +
  ylab("Total PM 2.5 Emissions") +
  xlab("Year")

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()
