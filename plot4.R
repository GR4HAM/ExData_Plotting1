#This code assumes you are in the correct working directory
#The working directory should contain the data set from UCI

#load the dataset
elecPowCons <- read.table("./household_power_consumption.txt", sep=";", header=TRUE)

#convert Date and time variables to R date and timestamp variables
elecPowCons$Date <- as.Date(strptime(elecPowCons$Date, format="%d/%m/%Y"))
elecPowCons$TimeStamp <- strptime(paste(elecPowCons$Date,elecPowCons$Time), format="%Y-%m-%d %H:%M:%S")

#extract the relevant data; we will only be using data from the dates 2007-02-01 and 2007-02-02
epSubset <- (elecPowCons[elecPowCons$Date == as.Date("2007-02-01") | elecPowCons$Date == as.Date("2007-02-02") ,])

#my system language is set to a different language. To get the x-axis label right, set the sys local LC_TIME constant to english
Sys.setlocale("LC_TIME", "en_US.UTF-8")

#convert factor levels to numeric levels
epSubset$Global_active_power <- as.numeric(levels(epSubset$Global_active_power))[epSubset$Global_active_power]
epSubset$Global_reactive_power <- as.numeric(levels(epSubset$Global_reactive_power))[epSubset$Global_reactive_power]
epSubset$Sub_metering_1 <- as.numeric(levels(epSubset$Sub_metering_1))[epSubset$Sub_metering_1]
epSubset$Sub_metering_2 <- as.numeric(levels(epSubset$Sub_metering_2))[epSubset$Sub_metering_2]
epSubset$Sub_metering_3 <- as.numeric(levels(epSubset$Sub_metering_3))[epSubset$Sub_metering_3]
epSubset$Voltage <- as.numeric(levels(epSubset$Voltage))[epSubset$Voltage]

#set the number of rows and columns for the plot
par(mfrow = c(2, 2))
## Draw a new plot and set the type, labels and title for each of the subplots
plot(epSubset$TimeStamp, epSubset$Global_active_power, type="l",  xlab="",  ylab="Global Active Power")
#second plot
plot(epSubset$TimeStamp, epSubset$Voltage, type='l', xlab="datetime", ylab="Voltage")
#third plot including legend
with(epSubset, plot(TimeStamp, Sub_metering_1,type = "n", xlab="", ylab="Energy sub metering"))
with(epSubset, lines(TimeStamp, Sub_metering_1, type="l", col="black"))
with(epSubset, lines(TimeStamp, Sub_metering_2, type="l", col="red"))
with(epSubset, lines(TimeStamp, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=c(1,1), lwd=c(2.5,2.5), col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty="n", 
       text.width = 80000, cex = .6, y.intersp=0.7)
#fourth plot
plot(epSubset$TimeStamp,epSubset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## Copy my plot to a PNG file
dev.copy(png, file = "plot4.png") 
# Close the PNG device
dev.off() 
