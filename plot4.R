#Check for data existense, if it doesn't exist , then load data by downloading
if(!file.exists("household_power_consumption.txt")){
        temp <- tempfile()
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "temp",method = "curl")
        unzip(temp)
        unlink(temp)
}
#Read the data
data <- read.table("household_power_consumption.txt", sep = ";",header = TRUE)

#Check for dplyr package to use filter function

if (!"dplyr" %in% installed.packages()){
        install.packages("dplyr")
}
library(dplyr)
#Get subset of data for 1/2 and 2/2
subset <- filter(data, data$Date %in% c("1/2/2007","2/2/2007"))
#Plotting global active power vs. date and time
globalActivePower <- as.numeric(subset$Global_active_power)
datetime <- strptime(paste(subset$Date, subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalReactivePower <- as.numeric(subset$Global_reactive_power)
voltage <- as.numeric(subset$Voltage)
subMetering1 <- as.numeric(subset$Sub_metering_1)
subMetering2 <- as.numeric(subset$Sub_metering_2)
subMetering3 <- as.numeric(subset$Sub_metering_3)


png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

garb <- dev.off()

