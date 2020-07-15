# First selection of the desired data
#extracting the data from the file with ? as NAs
mydt <- read.table("household_power_consumption.txt", sep=";", na.strings = "?")
#creating the date (date time) as "one element"
pp <- paste(mydt[,1], mydt[,2],sep=" ")
#adding the time object to the 2nd column (the 1st column is now useless since all is in the 2nd col.)
mydt[,2] <- as.POSIXct(strptime(pp, format="%d/%m/%Y %H:%M:%S"))

#selecting the data from the required time-range, removing the NA rows, and resetting the column names
thedata <- mydt[mydt[,2] >= "2007-02-01" & mydt[,2] <= "2007-02-03",]
thedata <- thedata[complete.cases(thedata),]
colnames(thedata) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# ----
#GRAPHs
  #they are all pretty straight forward, many were done before. | First, setting the plotspace to 2x2
par(mfrow=c(2,2))

  #first plot
plot(thedata$Time, as.numeric(thedata$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
#second plot (topright)
plot(thedata$Time, thedata$Voltage, type="l", xlab="datetime", ylab="Voltage")

  #third plot (bottom left)
plot(thedata$Time, thedata$Sub_metering_1, col="black", type="l", ylab="Energy sub metering", xlab="")
points(thedata$Time, thedata$Sub_metering_2, col="red", type="l")
points(thedata$Time, thedata$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.65, bty="n", xjust=1)

  #fourth plot (bottom right)
plot(thedata$Time, thedata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #saving the file to the png device
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()