library(ggplot2)
library(dplyr)
# Opening the two rds files

if(!file.exists("./data")){
  dir.create("./data")
}

NEI <- readRDS("/home/coral/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coral/data/Source_Classification_Code.rds")

# 6 Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

baltvsange <- NEI %>% 
  filter(fips == "24510" | fips =="06037") %>% 
  filter(type == "ON-ROAD")

baltsvsange_agg <- aggregate(Emissions ~ year + fips, baltvsange, sum)

ggplot(baltsvsange_agg, aes(year, Emissions, col = fips)) +
  geom_point() +
  geom_line() +
  ggtitle("Baltimore and Los Angeles PM 2.5 Motor Emisions", ) +
  ylab("PM 2.5 Motor Emissions") +
  xlab("Year")

dev.copy(png,"plot6.png", width=480, height=480)
dev.off()