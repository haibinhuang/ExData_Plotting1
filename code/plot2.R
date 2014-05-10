## Read in all data
allData <- read.csv2("household_power_consumption.txt", na.strings="?")
## subsetting the two day data
TwoDayData <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")
## complete cases
df <- TwoDayData[complete.cases(TwoDayData), ]

## Combine Date and Time and reformat to POSIX format
df$Time <- paste(df$Date, df$Time)
df$Time <- strptime(df$Time, format = "%d/%m/%Y %H:%M:%S")

## Change the data from factor to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

## start fresh
if (file.exists("plot2.png")) {
        file.remove("plot2.png")
}
## generating plot2 in png format
png(file = "plot2.png", bg = "transparent")
plot(df$Time, df$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()