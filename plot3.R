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

# create plot
with(hpc, plot(DateTime,
               Sub_metering_1,
               type="l",
               ylab="Energy sub metering",
               xlab=""))
with(hpc, lines(DateTime, Sub_metering_2, col="red"))
with(hpc, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", 
       lty=c(1,1,1),
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# save graphic to file
dev.copy(png, filename="plot3.png", width=480, height=480)
dev.off() 
