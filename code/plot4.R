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
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

## start fresh
if (file.exists("plot4.png")) {
        file.remove("plot4.png")
}

## generating plot4 in png format
png(file = "plot4.png", bg = "transparent")
par(mfcol=c(2,2))
plot(df$Time, df$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")

plot(df$Time, df$Sub_metering_1, type ="l", xlab="", 
     ylab="Energy sub metering", col = "black")
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
                            "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, bty = "n")

plot(df$Time, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(df$Time, df$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()