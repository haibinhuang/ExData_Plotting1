## Since the following file write code to "append" to file, start fresh
if (file.exists("out.txt")) {
        file.remove("out.txt") 
}
## Read in those lines with dates 2007-2-1 and 2007-2-2
file_in <- file("household_power_consumption.txt","r")
file_out <- file("out.txt","a")
x <- readLines(file_in, n=1)
writeLines(x, file_out) # copy headers
while(length(x)) {
        ind <- grep("^[1-2]/2/2007", x)
        if (length(ind)) writeLines(x[ind], file_out)
        x <- readLines(file_in, n=1440)
}
close(file_in)
close(file_out)

## Read into data frame
df <- read.csv2("out.txt", na.strings="?")

## Combine Date and Time and reformat to POSIX format
df$Time <- paste(df$Date, df$Time)
df$Time <- strptime(df$Time, format = "%d/%m/%Y %H:%M:%S")

## Change the data from factor to numeric
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

## start fresh
if (file.exists("plot3.png")) {
        file.remove("plot3.png")
}

## generating plot3 in png format
png(file = "plot3.png", bg = "transparent")
plot(df$Time, df$Sub_metering_1, type ="l", xlab="", 
     ylab="Energy sub metering", col = "black")
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
        "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1)
dev.off()
