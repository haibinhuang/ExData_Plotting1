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