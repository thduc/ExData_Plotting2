# Load the data
dataPath <- "~/Downloads/NEI_data/"

NEI <- readRDS(paste(dataPath, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(dataPath, "Source_Classification_Code.rds", sep = ""))

# Compute total emissions from PM2.5 decreased in the Baltimore City from 1999 to 2008
NEIBaltimoreCityTotalByYear <- aggregate(Emissions ~ year, data = subset(NEI, NEI$fips == "24510"), FUN = sum)

# Open the pnp file
png(filename = "plot2.png", width = 480, height = 480, units = "px")
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
plot(NEIBaltimoreCityTotalByYear$year, NEIBaltimoreCityTotalByYear$Emissions, type = "b", main = "Baltimore City", xlab = "Year", ylab = "Total PM2.5 emission")
# Close graphic device
dev.off()