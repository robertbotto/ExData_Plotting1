library(data.table)

# read data from file
DT <- fread("../data/household_power_consumption.txt", sep=";", 
            na.strings=c("?"))

#convert date string to date class
DT[,Date := as.Date(Date, format="%d/%m/%Y")] # slow!

# select rows by dates
consumption=DT[Date %between% c("2007-02-01", "2007-02-02")]

# select graphics device
png(filename="plot1.png", width=480, height=480)

# create plot
hist(consumption$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red")

dev.off() 
