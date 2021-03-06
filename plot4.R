
library(dplyr)
library(sqldf)
# Columns are Date;Time;Global_active_power;Global_reactive_power;
# Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;
# Sub_metering_3
colclass=c("Date", "character", "numeric", "numeric", "numeric",
           "numeric", "numeric", "numeric", "numeric")
startDate <- as.Date('1/2/2007', '%d/%m/%Y' )
endDate <- as.Date('2/2/2007', '%d/%m/%Y' )
query = "Select * from file"
df<-read.csv.sql("household_power_consumption.txt", colClasses=colclass,
             sep=";", sql= query, header=TRUE)
# Get the rows where data >= 2007-02-01 and date <= 2007-02-01
df<-df[as.Date(df$Date, '%d/%m/%Y')>=startDate,]
df<-df[as.Date(df$Date, '%d/%m/%Y')<=endDate,]
png("plot4.png", width=480, height=480)
d <- c("Thu", "Fri", "Sat")
par(mfrow=c(2,2))
# Plot 1
plot(df$Global_active_power, xaxt='n', type="l", xlab='', ylab="Global Active Power")
axis(1, at=c(0, nrow(df)/2,nrow(df)), label=d )

#Plot 2
plot(df$Voltage, xaxt='n', type="l", xlab='datetime', ylab="Voltage")
axis(1, at=c(0, nrow(df)/2,nrow(df)), label=d )


#Plot 3
plot(df$Sub_metering_1, xaxt='n', type="l", xlab='', ylab="Energy sub metering")
lines(df$Sub_metering_2, col='red')
lines(df$Sub_metering_3, col='blue')
axis(1, at=c(0, nrow(df)/2,nrow(df)), label=d )
legend(x="topright", y=NULL, 
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lty=c(1,1,1), lwd=c(1.5,1.5,1.5),col=c("black","blue","red"))

#Plot 4
plot(df$Global_reactive_power, xaxt='n', type="l", xlab='datetime', ylab="Global_reactive_power")
axis(1, at=c(0, nrow(df)/2,nrow(df)), label=d )

dev.off()
