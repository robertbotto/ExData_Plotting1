library(data.table)

# read data from file
DT <- fread("../data/household_power_consumption.txt", sep=";", 
            na.strings = c("?"))

#convert date string to date class
DT[,Date := as.Date(Date, format="%d/%m/%Y")] # slow!

# select rows by dates
consumption=DT[Date %between% c("2007-02-01", "2007-02-02")]

# select graphics device
png(filename = "plot2.png", width = 480, height = 480)

# create plot
with(consumption, plot(Global_active_power,
     type="l",
     xaxt="n",
     ylab="Global Active Power (kilowatts)",
     xlab=""))

# find midpoint for x axis
midpoint <- consumption[,which(Date == "2007-02-02" & 
                                   Time == c("00:00:00"))]
axis(side=1, 
     at=c(1,midpoint,nrow(consumption)), 
     labels = c("Thu","Fri","Sat"),
     tck=-.05)

dev.off() 
