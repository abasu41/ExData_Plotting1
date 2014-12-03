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
png("plot1.png")
hist(df$Global_active_power, col="red", main="Global Active Power", xlab="Global active power (kilowatts)")
dev.off()
# save plot to file
