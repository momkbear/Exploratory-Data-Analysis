#load required library
library(dplyr)
library(RCurl)
library(varhandle)

#read text file
setwd("C:/Users/JKK/Assignments/Exploratory Data Analysis")
data<-read.table("C:/Users/JKK/Assignments/Exploratory Data Analysis/household_power_consumption.txt",header = TRUE,sep = ";")

#take look
str(data)
names(data)

#filter and subset data recorded in between 1 Feb and 2 Feb 2007
data_jan<-filter(data,Date == "1/2/2007")
data_feb<-filter(data,Date == "2/2/2007")
power_data<-rbind.data.frame(data_jan,data_feb)

#take a look
head(power_data)

#create new columns for date and weekday
power_data<-mutate(power_data,r_date = as.Date(power_data$Date, format="%d/%m/%Y"))
power_data<-mutate(power_data,weekday = weekdays(r_date))
power_data$Voltage<-unfactor(power_data$Voltage)
power_data$Global_active_power<-unfactor(power_data$Global_active_power)

#clean data
rm(data,data_jan,data_feb)
str(power_data)
names(power_data)

#plot histogram
hist(power_data$Global_active_power,freq = 200,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

#create png file
dev.copy(png,file="plot1.png")
dev.off()