#This code assumes you are in the correct working directory
#The working directory should contain the data set from UCI

#load the dataset
elecPowCons <- read.table("./household_power_consumption.txt", sep=";", header=TRUE)

#convert Date variable to R date variable
elecPowCons$Date <- as.Date(strptime(elecPowCons$Date, format="%d/%m/%Y"))

#extract the relevant data; we will only be using data from the dates 2007-02-01 and 2007-02-02
epSubset <- (elecPowCons[elecPowCons$Date == as.Date("2007-02-01") | elecPowCons$Date == as.Date("2007-02-02") ,])

#convert factor levels to numeric levels
epSubset$Global_active_power <- as.numeric(levels(epSubset$Global_active_power))[epSubset$Global_active_power]

## Draw a new plot and set the color of the bars to red, add labels and title
hist(epSubset$Global_active_power, col="red", breaks=12, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency") 

## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png") 
# Close the PNG device
dev.off() 
