# Plot3
# Irwin Cassells
# 30 July 2017

# Clear global environment
rm(list = ls())

# Working directory
if(!require(rstudioapi)) install.packages("rstudioapi")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Remove warnings - because they annoy me
options(warn=-1)

# Installs packages if they are not installed already/Just like having them there, even if I don't need them
if(!require(dplyr)) install.packages("dplyr")
if(!require(zoo)) install.packages("zoo")
if(!require(tidyr)) install.packages("tidyr")
if(!require(lubridate)) install.packages("lubridate")

# Imports packages
require("dplyr")
require("zoo")
require("tidyr")
require("lubridate")

# Imports the data from the file
rawData = as.data.frame(read.table("household_power_consumption.txt",sep = ";",stringsAsFactors = F, header = T))

# Convert data and time into those data types
rawData$Date = as.Date(rawData$Date,format = "%d/%m/%Y")

# Keep only the data between those dates and remove massive file
workingData = rawData[rawData$Date == "2007-02-01" | rawData$Date == "2007-02-02",]
rm(rawData)

# Make a new field for date
workingData$completeDate =  strptime(paste(workingData$Date,workingData$Time,sep = " "),format = "%Y-%m-%d %T")

# Open graphics device
par(mfrow = c(1,1))
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# Initiate plot
with(workingData,plot(completeDate,Sub_metering_1,type = "n",ylab = "Energy sub metering", xlab = ""))

# Plot all three
with(workingData,lines(completeDate,Sub_metering_1,col = "black"))
with(workingData,lines(completeDate,Sub_metering_2,col = "red"))
with(workingData,lines(completeDate,Sub_metering_3,col = "blue"))

# Add legend
legend("topright", lty = c(1,1,1), col = c("black","red","blue"),legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Close device
dev.off()
