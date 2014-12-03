install.packages('sqldf')

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
png("plot3.png", width=480, height=480)
d <- c("Thu", "Fri", "Sat")
plot(df$Sub_metering_1, xaxt='n', type="l", xlab='', ylab="Global active power (kilowatts)")
lines(df$Sub_metering_2, col='red')
lines(df$Sub_metering_3, col='blue')
axis(1, at=c(0, nrow(df)/2,nrow(df)), label=d )
legend(x=1300,y=40, 
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lty=c(1,1,1), lwd=c(1.5,1.5,1.5),col=c("black","blue","red"))

dev.off()
