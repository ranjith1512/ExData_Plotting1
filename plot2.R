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
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
garb <- dev.off()
