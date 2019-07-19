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

## ensure 1 plot per page
par(mfcol = c(1,1))

## build plot #3
attach(hpcDatedSubset)
plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(datetime, Sub_metering_2, col = "Red")
lines(datetime, Sub_metering_3, col = "Blue")
legend("topright", lty = 1, lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .7)

## save to png format
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
detach(hpcDatedSubset)
