## ----------------------------------------------------------------------------
## plot 3
## ----------------------------------------------------------------------------
## read.csv.sql will be used to read in data from February 1, 2007 and 
## February 2, 2007. The data set is assumed to be located within the current
## working directory. Function plot() will be used to create Plot 3 as well as
## points() and legend(). dev.copy() and dev.off() will create the .png file. 
## Date and Time will be concatenated using paste() and changed to POSIXlt 
## using dmy_hms and added to the data set for plotting.

## Load sqldf library for read.csv.sql() function.
library(sqldf)

## Get the current working directory and set the filepath.
wd <- getwd()
if(!is.null(wd)){setwd(wd)}
filename <- "./household_power_consumption.txt"

## Read in data and close connections to avoid warnings.
epc <- read.csv.sql(filename, sql = "select * from file where Date in 
                    ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";")
closeAllConnections()

## Create Energy sub metering plotted on date-time using line format after creating 
## dmy_hms date-time variable.
library(stringi)
library(lubridate)
epc$datetime <- dmy_hms(paste(epc$Date, epc$Time, sep = " "))
plot(epc$datetime, epc$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
points(epc$datetime, epc$Sub_metering_1, type = "l", col = "black")
points(epc$datetime, epc$Sub_metering_2, type = "l", col = "red")
points(epc$datetime, epc$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty=1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot 3")
dev.off()
