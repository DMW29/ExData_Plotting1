## Plot 1
## ----------------------------------------------------------------------------
## read.csv.sql will be used to read in data from February 1, 2007 and 
## February 2, 2007. The data set is assumed to be located within the current
## working directory. Functions with() and hist() will be used to create 
## Plot 1. dev.copy() and dev.off() will create the .png file.

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

## Create Global Active Power histogram.
with(epc, hist(Global_active_power, col = "red", main = "Global Active Power", 
               xlab = "Global Active Power (kilowatts)", ylab = "Frequency"))

## Create the .png file and close the graphics device.
dev.copy(png, file = "Plot 1")
dev.off()