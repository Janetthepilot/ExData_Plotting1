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

## build plot #1
attach(hpcDatedSubset)
hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "Red")

## save to png format
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
detach(hpcDatedSubset)