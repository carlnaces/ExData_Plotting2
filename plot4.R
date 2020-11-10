library(ggplot2)
library(dplyr)
# Opening the two rds files

if(!file.exists("./data")){
  dir.create("./data")
}

NEI <- readRDS("/home/coral/data/summarySCC_PM25.rds")
SCC <- readRDS("/home/coral/data/Source_Classification_Code.rds")

# 4 Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

SCCcoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T), ]
# dim(SCCcoal)
# [1] 239  15
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC, ]
# > dim(NEIcoal)
# [1] 53400     6
totalcoal <- aggregate(Emissions ~ year + type, NEIcoal, sum)

# Plot 4

ggplot(totalcoal, aes(year, Emissions, col = type))+
  geom_point() +
  geom_line() +
  ggtitle("Total Coal PM 2.5 Emisions by type", ) +
  ylab("Total PM 2.5 Emissions") +
  xlab("Year")

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
