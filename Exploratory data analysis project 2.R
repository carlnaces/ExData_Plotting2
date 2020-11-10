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
     ylab = "Total PM 2.5 Emissions"
)

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
     ylab = "Total PM 2.5 Emissions"
)

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
  
  


