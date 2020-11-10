library(ggplot2)
library(dplyr)
# Opening the two rds files

if(!file.exists("./data")){
  dir.create("./data")
}

NEI <- readRDS("/home/coral/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coral/data/Source_Classification_Code.rds")

# 5 How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?

baltmotor <- NEI %>% 
  filter(fips == "24510" & NEI$type == "ON-ROAD")
totalbaltmotor <- aggregate(Emissions ~ year, baltmotor, sum)

# Plot
ggplot(totalbaltmotor, aes(year, Emissions)) +
  geom_point() +
  geom_line() +
  ggtitle("Total Baltimore PM 2.5 Motor Emisions", ) +
  ylab("Total PM 2.5 Emissions") +
  xlab("Year")

dev.copy(png,"plot5.png", width=480, height=480)
dev.off()