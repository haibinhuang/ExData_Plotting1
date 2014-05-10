## Read in all data
allData <- read.csv2("household_power_consumption.txt", na.strings="?")
## subsetting the two day data
TwoDayData <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")
## complete cases
df <- TwoDayData[complete.cases(TwoDayData), ]

## Change the data from factor to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

## start fresh
if (file.exists("plot1.png")) {
        file.remove("plot1.png")
}
## Making plot1 in png format
png(file = "plot1.png", bg = "transparent")
hist(df$Global_active_power, col="red", 
     xlab ="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()