## Exploratory Data Analysis Week1 Project - JHU Coursera
## Author: Xinyang Wang

# Load necessary package
library(sqldf)


# Download data file and unzip
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFile <- "household_power_consumption.zip"
if(!file.exists(dataFile)) {
        download.file(url, dataFile, method = "curl")
}
if(!file.exists("household_power_consumption.txt")){
        unzip(dataFile)
}

# Read data only of 2017/2/1 and 2017/2/2
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")

# Transfer Date variable to weekday
dateTime <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")


# Creat the plot and save as PNG file
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
with(data, {
        plot(dateTime, data$Global_active_power, xlab = "", 
             ylab =  "Global Active Power" ,type = "l")
        plot(dateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering",type = "n")
        points(dateTime, data$Sub_metering_1, type = "l")
        points(dateTime, data$Sub_metering_2, col = "red", type = "l")
        points(dateTime, data$Sub_metering_3, col = "blue", type = "l")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"), lty = 1, box.lty = 0)
        plot(dateTime, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
        plot(dateTime, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",type = "l")
})
dev.off()