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
png("plot2.png", width = 480, height = 480)
plot(dateTime, data$Global_active_power, xlab = "", 
     ylab =  "Global Active Power (kilowatts)" ,type = "l")
dev.off()