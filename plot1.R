install.packages('dplyr')
library(dplyr)
# Columns are Date;Time;Global_active_power;Global_reactive_power;
# Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;
# Sub_metering_3
colclass=c("Date", "character", "numeric", "numeric", "numeric",
           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
df<-read.csv("household_power_consumption.txt", colClasses=colclass,
             sep=";", header=TRUE, na.strings="?")
