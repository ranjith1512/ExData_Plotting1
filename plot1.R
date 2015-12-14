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
#Plotting histogram of global active power
globalActivePower <- as.numeric(subset$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()