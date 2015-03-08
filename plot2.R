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

## Draw a new plot and set the type, titles and labels
plot(epSubset$TimeStamp, epSubset$Global_active_power, type="l",  xlab="",  ylab="Global Active Power (kilowatts)")

## Copy my plot to a PNG file
dev.copy(png, file = "plot2.png") 
# Close the PNG device
dev.off() 
