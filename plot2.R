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
with(hpc, plot(DateTime, Global_active_power,
               type="l",
               ylab="Global Active Power (kilowatts)",
               xlab=""))

# save graphic to file
dev.copy(png, filename="plot2.png", width=480, height=480)
dev.off() 