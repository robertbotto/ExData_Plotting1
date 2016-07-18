library(sqldf)

# read data from file
hpc <- read.csv.sql("../data/household_power_consumption.txt", sep=";", 
                    sql="SELECT * 
                    FROM file 
                    WHERE Date IN ('1/2/2007','2/2/2007')")

#convert ?'s to NA's
hpc[hpc=="?"]=NA

# add datetime column
hpc$DateTime <- as.POSIXct(paste(hpc$Date, hpc$Time), 
                           format="%d/%m/%Y %H:%M:%S")

# 4 subplots
par(mfrow = c(2,2)) 

# create plot 1
with(hpc, plot(DateTime, Global_active_power,
               type="l",
               ylab="Global Active Power",
               xlab=""))


# create plot 2
with(hpc, plot(DateTime, Voltage,
               type="l",
               ylab="Voltage",
               xlab="datetime"))

# create plot 3
with(hpc, plot(DateTime,
               Sub_metering_1,
               type="l",
               ylab="Energy sub metering",
               xlab=""))
with(hpc, lines(DateTime, Sub_metering_2, col="red"))
with(hpc, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", 
       lty=c(1,1,1),
       bty="n",
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# create plot 4
with(hpc, plot(DateTime, Global_reactive_power,
               type="l",
               ylab="Global_reactive_power",
               xlab="datetime"))

# save graphic to file
dev.copy(png, filename="plot4.png", width=480, height=480)
dev.off() 
