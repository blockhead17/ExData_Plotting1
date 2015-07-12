###plot3.R

library(data.table)
##Read in data directly from the text file.  Only rows that meet the regular
##expression checking for the appropriate dates (with or without leading zeroes)
##will be included in the resulting data table.
DT<-fread("grep ^[0?1-2]/[0?2]/2007 household_power_consumption.txt", sep = ";",skip=1)

##Add some sensible names to the data set
setnames(DT,1:9,c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Put the date and time variables into a datetime format
DT$Date<-as.Date(DT$Date,"%d/%m/%Y")
DT$DateTime<-as.POSIXct(paste(DT$Date, DT$Time))

##Open the png device
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

##Create empty plot
plot(DT$DateTime,DT$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")

##Add lines to the plot for each sub-metering variable
##Each line represents that measurement over time
lines(DT$DateTime,DT$Sub_metering_1, col="black")
lines(DT$DateTime,DT$Sub_metering_2, col="red")
lines(DT$DateTime,DT$Sub_metering_3, col="blue")

##Add a legend to the plot
legend("topright", lty=c(1,1),
       col = c("black", "red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Close the png device
dev.off()


