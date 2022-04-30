library("data.table")

setwd("~/Downloads")

#reads and subsets data, where missing values are coded as '?'
powerDT <- data.table::fread(input = "household_power_consumption.txt", 
                             na.strings = "?")

#changes graph so frequency won't be in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), 
        .SDcols = c("Global_active_power")]

#change date column to Date class in R
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

#selecting dates from 2007-02-01 and 2007-02-02
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width = 480, height = 480)

#Plot 1
hist(powerDT[, Global_active_power], main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")

dev.off()
