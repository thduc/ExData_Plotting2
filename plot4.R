# Load the data
dataPath <- "~/Downloads/NEI_data/"

NEI <- readRDS(paste(dataPath, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(dataPath, "Source_Classification_Code.rds", sep = ""))

# Coal data
Coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
Coal <- SCC[Coal, ]
NEICoal <- NEI[NEI$SCC %in% Coal$SCC, ]

# Compute total emissions from coal combustion-related sources in the United States from 1999 to 2008
NEICoalTotalByYear <- aggregate(Emissions ~ year, data = NEICoal, FUN = sum)

# Open the pnp file
png(filename = "plot4.png", width = 480, height = 480, units = "px")
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
plot(NEICoalTotalByYear$year, NEICoalTotalByYear$Emissions, type = "b", main = "United States", xlab = "Year", ylab = "Total emissions from coal combustion-related sources")
# Close graphic device
dev.off()