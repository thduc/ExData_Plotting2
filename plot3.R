# Load the data
dataPath <- "~/Downloads/NEI_data/"

NEI <- readRDS(paste(dataPath, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(dataPath, "Source_Classification_Code.rds", sep = ""))

# Compute total emissions from PM2.5 decreased in the Baltimore City from 1999 to 2008 by type
NEIBaltimoreCity <- aggregate(Emissions ~ year + type, data = subset(NEI, NEI$fips == "24510"), FUN = sum)

# Open the pnp file
png(filename = "plot3.png", width = 480, height = 480, units = "px")
# Use the ggplot2 plotting system
library(ggplot2)
g <- ggplot(NEIBaltimoreCity, aes(year, Emissions, color = type))
g <- g + geom_line()
print(g)
# Close graphic device
dev.off()