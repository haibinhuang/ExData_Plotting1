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
