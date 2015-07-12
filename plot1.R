###plot1.R

library(data.table)
##Read in data directly from the text file.  Only rows that meet the regular
##expression checking for the appropriate dates (with or without leading zeroes)
##will be included in the resulting data table.
DT<-fread("grep ^[0?1-2]/[0?2]/2007 household_power_consumption.txt", sep = ";",skip=1)

##Add some sensible names to the data set
setnames(DT,1:9,c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Open the png device
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)
##Create a histogram of global active power
hist(DT$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (kilowatts)",col = "red")
##Close the png device
dev.off()
