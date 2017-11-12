#load required library
library(dplyr)
library(RCurl)
library(varhandle)

#read text file, code from plot1.R
setwd("C:/Users/JKK/Assignments/Exploratory Data Analysis")
data<-read.table("C:/Users/JKK/Assignments/Exploratory Data Analysis/household_power_consumption.txt",header = TRUE,sep = ";")

#take a look, code from plot1.R 
str(data)
names(data)

#filter and subset data recorded in between 1 Feb and 2 Feb 2007, code from plot1.R
data_jan<-filter(data,Date == "1/2/2007")
data_feb<-filter(data,Date == "2/2/2007")
power_data<-rbind.data.frame(data_jan,data_feb)

#take a look
head(power_data)


#create new columns for date and weekday, code modified from plot1.R
power_data$Voltage<-unfactor(power_data$Voltage)
power_data$Global_active_power<-unfactor(power_data$Global_active_power)
power_data$Date <- as.Date(power_data$Date,"%d/%m/%Y")
power_data<-cbind(power_data, "DateTime" = as.POSIXct(paste(power_data$Date, power_data$Time)))


#clean data
rm(data,data_jan,data_feb)
str(power_data)
names(power_data)

#plot line graph
plot(power_data$Global_active_power ~ power_data$DateTime, type="l", xlab= "", ylab="Global Active power (kilowatts)")

#create png file
dev.copy(png,file="plot2.png")
dev.off()