# Plot2
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

# Plot
par(mfrow = c(1,1))
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(workingData$completeDate,workingData$Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()

# Clear memory
rm(list = ls())
