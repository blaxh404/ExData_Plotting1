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
#GRAPH
#creating the histogram in all the plotspace, converting the global active power to numeric and copying the result into the png device and closing it
par(mfrow=c(1,1))
hist(as.numeric(thedata$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()