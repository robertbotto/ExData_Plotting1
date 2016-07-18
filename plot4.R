library(data.table)

# read data from file
DT <- fread("../data/household_power_consumption.txt", sep=";", 
            na.strings = c("?"))

#convert date string to date class
DT[,Date := as.Date(Date, format="%d/%m/%Y")] # slow!

# select rows by dates
consumption=DT[Date %between% c("2007-02-01", "2007-02-02")]

# select graphics device
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2)) # 4 subplots

# find midpoint for x axis
midpoint <- consumption[,which(Date == "2007-02-02" & 
                                   Time == c("00:00:00"))]

# create plot 1
with(consumption, plot(Global_active_power,
                       type="l",
                       xaxt="n",
                       ylab="Global Active Power",
                       xlab=""))

axis(side=1, 
     at=c(1,midpoint,nrow(consumption)), 
     labels = c("Thu","Fri","Sat"),
     tck=-.05)

# create plot 2
with(consumption, plot(Voltage,
                       type="l",
                       xaxt="n",
                       ylab="Voltage",
                       xlab="datetime"))

axis(side=1, 
     at=c(1,midpoint,nrow(consumption)), 
     labels = c("Thu","Fri","Sat"),
     tck=-.05)

# create plot 3
with(consumption, plot(Sub_metering_1,
                       type="l",
                       xaxt="n",
                       ylab="Energy sub metering",
                       xlab=""))
with(consumption, lines(Sub_metering_2, col="red"))
with(consumption, lines(Sub_metering_3, col="blue"))

axis(side=1, 
     at=c(1,midpoint,nrow(consumption)), 
     labels = c("Thu","Fri","Sat"),
     tck=-.05)

legend("topright", 
       lty=c(1,1,1),
       bty="n",
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# create plot 4
with(consumption, plot(Global_reactive_power,
                       type="l",
                       xaxt="n",
                       ylab="Global_reactive_power",
                       xlab="datetime"))

axis(side=1, 
     at=c(1,midpoint,nrow(consumption)), 
     labels = c("Thu","Fri","Sat"),
     tck=-.05)

dev.off() 
