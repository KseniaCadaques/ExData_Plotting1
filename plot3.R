fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
datafile <- "household_power_consumption.txt"

## Checking if the working directory with the script 
## does not contain already the data files (either in txt or zip form).
## If not, we download the zip file and unzip it in the working directory.

if(!file.exists(datafile)){
        if(!file.exists(zipfile)){
                download.file(fileUrl,method="curl")
                unzip(zipfile)
        }
        else {
                unzip(zipfile)
        }
}

## Getting the names of the columns.

data <- read.table(datafile, 
                   header=TRUE, sep=";", na.strings = "?", nrows=5)
names <- names(data)

## Getting the necessary data without reading all the file into memory.

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                   na.strings = "?", nrows=2880, skip=66636, col.names= names, 
                   stringsAsFactors = FALSE)

## Converting Date and Time columns to "POSIXct" format with the lubridate library.

library(lubridate)
data$DateTime <- dmy_hms(paste(Date, Time))

## Creating "plot3.png" and copying it into the working directory.

plot(data$DateTime, 
     data$Sub_metering_1, 
     type="l", 
     col="black",
     xlab = "",
     ylab = "Energy sub metering")

lines(data$DateTime, 
     data$Sub_metering_2,
     col="red1")

lines(data$DateTime, 
      data$Sub_metering_3,
      col="blue")

legend("topright", legend = names[7:9], col = c("black", "red1", "blue"), lty = 1,
       y.intersp=0.5)

dev.copy(png, file = "plot3.png")
dev.off()