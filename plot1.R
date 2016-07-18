library(sqldf)

# read data from file
hpc <- read.csv.sql("../data/household_power_consumption.txt", sep=";", 
                    sql="SELECT * 
                    FROM file 
                    WHERE Date IN ('1/2/2007','2/2/2007')")

#convert ?'s to NA's
hpc[hpc=="?"]=NA

# create plot
hist(hpc$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red")

# save graphic to file
dev.copy(png, filename="plot1.png", width=480, height=480)
dev.off() 
