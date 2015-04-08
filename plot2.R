#Coursera: Exploratory Data Analysis
#Project 1: Plot 2

#Only download data once (20mb)
#if(!file.exists("./data")){dir.create("./data")}
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/power_consumption.zip")

#Manipulate data in zip and extract 2007-02-01 to 2007-02-02 data.
#Unknown error from readLines()...work with extracted file.
#zipconnection <- unz("./data/power_consumption.zip", "household_power_consumption.txt")
#powerdf <- read.table(zipconnection, skip = grep("1/2/2007", readLines(zipconnection)), nrows = 2879, sep=";")

#Unzip file and extract 2007-02-01 to 2007-02-02 data
#Missing values coded as "?"
#unzip("./data/power_consumption.zip", "household_power_consumption.txt", exdir = "./data")
powerdf <- read.table("./data/household_power_consumption.txt", skip = grep("1/2/2007", readLines("./data/household_power_consumption.txt")), nrows = 2879, sep = ";", header=FALSE)

names(powerdf) <- c("date","time","globalActivePower","globalReactivePower","voltage","globalIntensity","subMetering1","subMetering2","subMetering3")

require(lubridate)
require(dplyr)

powerdf <- rename(powerdf, datestr = date, timestr = time)
powerdf <- mutate(powerdf, date = dmy(datestr))
powerdf <- mutate(powerdf, time = hms(timestr))
powerdf <- mutate(powerdf, datetime = dmy_hms(paste(datestr, timestr)))

png(filename = "plot2.png")
with(powerdf, plot(datetime, globalActivePower,xlab = "", ylab = "Global Active Power (kilowatts)", type="n") )
with(powerdf, lines(datetime, globalActivePower))
dev.off()
