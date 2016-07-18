library(data.table)

# read data from file
DT <- fread("../data/household_power_consumption.txt", sep=";", 
            na.strings = c("?"))

#convert date string to date class
DT[,Date := as.Date(Date, format="%d/%m/%Y")] # slow!

# select rows by dates
consumption=DT[Date %between% c("2007-02-01", "2007-02-02")]

# select graphics device
png(filename = "plot3.png", width = 480, height = 480)

# create plot
with(consumption, plot(Sub_metering_1,
                       type="l",
                       xaxt="n",
                       ylab="Energy sub metering",
                       xlab=""))
with(consumption, lines(Sub_metering_2, col="red"))
with(consumption, lines(Sub_metering_3, col="blue"))

# find midpoint for x axis
midpoint <- consumption[,which(Date == "2007-02-02" & 
                                   Time == c("00:00:00"))]
axis(side=1, 
     at=c(1,midpoint,nrow(consumption)), 
     labels = c("Thu","Fri","Sat"),
     tck=-.05)

legend("topright", 
       lty=c(1,1,1),
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() 
