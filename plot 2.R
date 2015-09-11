## ----------------------------------------------------------------------------
## plot 2
## ----------------------------------------------------------------------------
## read.csv.sql will be used to read in data from February 1, 2007 and 
## February 2, 2007. The data set is assumed to be located within the current
## working directory. Function plot() will be used to create Plot 2. The png 
## device will be used to create the file. Date and Time will be concatenated
## using paste() and changed to POSIXlt using dmy_hms and added to the data set
## for plotting.

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

## Open png device
png(filename = "plot 2.png")

## Create Global Active Power plotted on Day using line format after creating 
## dmy_hms date-time variable.
library(stringi)
library(lubridate)
epc$datetime <- dmy_hms(paste(epc$Date, epc$Time, sep = " "))
plot(epc$datetime, epc$Global_active_power, type = "l", xlab = "", ylab = 
             "Global Active Power (kilowatts)")

## Close the png graphics device
dev.off()
