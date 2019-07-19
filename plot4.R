library(datasets)
library(utils)
library(graphics)

## read in data
rm(list = ls())
hhdPowerConsumption <- "./household_power_consumption.txt"
hpcData <- read.table(hhdPowerConsumption, header = TRUE, sep = ",", stringsAsFactors = FALSE)

## limiting data to specified dates
hpcData$Date <- as.Date(hpcData$Date, format = "%d/%m/%y")
hpcDatedSubset <- subset(hpcData, subset = (Date  >= "1/2/2007" & Date <= "2/2/2007"))

## converting time, dates
hpcData$date.time <- strptime(paste(hpcData$Date, hpcData$Time), "%y-%m-%d %H:$M:$S")

## build plot #4
par(mfcol = c(2,2))
## Global Active Power plot
hpcData$date.time <- as.POSIXct(hpcData$date.time)
attach(hpcDatedSubset)
plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Energy Sub Metering plot
plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(datetime, Sub_metering_2, col = "Red")
lines(datetime, Sub_metering_3, col = "Blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col = c("black", "red", "blue"), bty = "n", cex = 0.6)

## Voltage plot
plot(datetime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Global Reactive Power plot
plot(datetime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## save to png format
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
detach(hpcDatedSubset)