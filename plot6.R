# Load the data
dataPath <- "~/Downloads/NEI_data/"

NEI <- readRDS(paste(dataPath, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(dataPath, "Source_Classification_Code.rds", sep = ""))

# Motor vehicle data
Motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
Motor <- SCC[Motor, ]

# Baltimore City or Los Angeles County
NEISubset <- subset(NEI, NEI$fips == "24510" | NEI$fips == "06037")

# Motor vehicle only
NEISubset <- NEISubset[NEISubset$SCC %in% Motor$SCC, ]

# Compute total emissions by year and by city
NEISubsetAggregate <- aggregate(Emissions ~ year + fips, data = NEISubset, FUN = sum)

# Open the pnp file
png(filename = "plot6.png", width = 480, height = 480, units = "px")
# Use the ggplot2 plotting system
library(ggplot2)
g <- ggplot(NEISubsetAggregate, aes(year, Emissions, color = fips))
g <- g + geom_line()
print(g)
# Close graphic device
dev.off()