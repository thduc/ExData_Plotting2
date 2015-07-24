# Load the data
dataPath <- "~/Downloads/NEI_data/"

NEI <- readRDS(paste(dataPath, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(dataPath, "Source_Classification_Code.rds", sep = ""))

# Motor vehicle data
Motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
Motor <- SCC[Motor, ]

# Baltimore City
NEIBC <- subset(NEI, NEI$fips == "24510")
# Motor vehicle in Baltimore City
NEIMotorBC <- NEIBC[NEIBC$SCC %in% Motor$SCC, ]

NEIBaltimoreCity <- aggregate(Emissions ~ year, data = NEIMotorBC, FUN = sum)

# Open the pnp file
png(filename = "plot5.png", width = 480, height = 480, units = "px")
plot(NEIBaltimoreCity$year, NEIBaltimoreCity$Emissions, type = "b", main = "Baltimore City", xlab = "Year", ylab = "Total emissions from motor vehicle")
# Close graphic device
dev.off()