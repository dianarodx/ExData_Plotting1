library("data.table")

setwd("~/Downloads")

#reads and subsets data, where missing values are coded as '?'
powerDT <- data.table::fread(input = "household_power_consumption.txt", 
                             na.strings = "?")

#changes graph so frequency won't be in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), 
        .SDcols = c("Global_active_power")]

#making table able to be graphed by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), 
                                 format = "%d/%m/%Y %H:%M:%S")]

#selecting dates from 2007-02-01 and 2007-02-02
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width = 480, height = 480)

#Plot 2
plot(x = powerDT[, dateTime], y = powerDT[,Global_active_power], type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()