###plot4.R

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
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)

##Set the graphic parameters for four plots to be displayed in panels (2 x 2)
##Order goes across the top row and then across the bottom row
par(mfrow = c(2, 2))

##Plot #1 - Top left panel (this is the same plot from plot2.R with the exception
##of a slightly different y-axis label)
plot(DT$DateTime,DT$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

##Plot #2 - Top right panel
plot(DT$DateTime,DT$Voltage, type="l", xlab="datetime", ylab="Voltage")

##Plot #3 - Bottom left panel (this is the same plot from plot3.R with the exception
##of no box around the legend)
plot(DT$DateTime,DT$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(DT$DateTime,DT$Sub_metering_1, col="black")
lines(DT$DateTime,DT$Sub_metering_2, col="red")
lines(DT$DateTime,DT$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1),
       col = c("black", "red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

##Plot #4 - Bottom right panel
plot(DT$DateTime,DT$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

##Close the png device
dev.off()
