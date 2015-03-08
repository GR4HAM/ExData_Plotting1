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
epSubset$Sub_metering_1 <- as.numeric(levels(epSubset$Sub_metering_1))[epSubset$Sub_metering_1]
epSubset$Sub_metering_2 <- as.numeric(levels(epSubset$Sub_metering_2))[epSubset$Sub_metering_2]
epSubset$Sub_metering_3 <- as.numeric(levels(epSubset$Sub_metering_3))[epSubset$Sub_metering_3]

## Draw a new plot and set the type, title and labels. 
with(epSubset, plot(TimeStamp, Sub_metering_1,type = "n", xlab="", ylab="Energy sub metering"))
#call each of the sub_metering variables separately to plot them in a separate color
with(epSubset, lines(TimeStamp, Sub_metering_1, type="l", col="black"))
with(epSubset, lines(TimeStamp, Sub_metering_2, type="l", col="red"))
with(epSubset, lines(TimeStamp, Sub_metering_3, type="l", col="blue"))
#set the legend
legend("topright", lty=c(1,1), lwd=c(2.5,2.5), col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), text.width = 40000, cex = .7)

## Copy my plot to a PNG file
dev.copy(png, file = "plot3.png") 
# Close the PNG device
dev.off() 
