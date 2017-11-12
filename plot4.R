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

#clean data, code from plot 1
rm(data,data_jan,data_feb)
str(power_data)
names(power_data)

#plot data
par(mfrow=c(2,2))
with(power_data,{
    plot(power_data$DateTime,as.numeric(as.character(power_data$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
    plot(power_data$DateTime,as.numeric(as.character(power_data$Voltage)), type="l",xlab="datetime",ylab="Voltage")
    plot(power_data$DateTime,power_data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    with(power_data,lines(DateTime,as.numeric(as.character(Sub_metering_1))))
    with(power_data,lines(DateTime,as.numeric(as.character(Sub_metering_2)),col="red"))
    with(power_data,lines(DateTime,as.numeric(as.character(Sub_metering_3)),col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    plot(power_data$DateTime,as.numeric(as.character(power_data$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

#create png file
dev.copy(png,file="plot4.png")
dev.off()