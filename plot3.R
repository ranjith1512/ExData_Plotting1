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
#Plotting submetering 
globalActivePower <- as.numeric(subset$Global_active_power)
datetime <- strptime(paste(subset$Date, subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
subMetering1 <- as.numeric(subset$Sub_metering_1)
subMetering2 <- as.numeric(subset$Sub_metering_2)
subMetering3 <- as.numeric(subset$Sub_metering_3)
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
garb <- dev.off()