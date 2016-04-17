# Loading data into R
## First get file into your R working directory
### So you can read it as I did below

data <- read.table("household_power_consumption.txt", 
                   header = T, sep = ";", na.strings="?", 
                   stringsAsFactors=F)

## Combinning and Converting date/time 
## info into the appropriate classes

data$DateTime <- paste(data$Date,data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

subsetData <- data[(data$Date >= "2007-02-01" & 
              data$Date <="2007-02-02"),] 

## I just want my data to look clean when I view it
## So I got the dplyr package and use it's data frame function

subsetDatafinal <- tbl_df(subsetData)

# Plot number 4

png("plot4.png", width=480, height=480)

## Partition the ploting device for the four plots

par(mfrow = c(2,2), mar = c(2,4,1,1))

## Plot number 4 of 1

with(subsetDatafinal, plot(DateTime, Global_active_power, 
    type="l", xlab="", ylab="Global Active Power)"))

## Plot number 4 of 2
with(subsetDatafinal, plot(DateTime, Voltage, 
    type="l", xlab="Date Time", ylab="Voltage"))

## Plot number 4 of 3

with(subsetDatafinal, plot(DateTime, Sub_metering_1, 
    type="l", xlab="", ylab="Power Sub Metering")) 
with(subsetDatafinal, lines(DateTime, Sub_metering_2, 
    type="l", xlab="", ylab="Power Sub Metering", col = "red"))
with(subsetDatafinal, lines(DateTime, Sub_metering_3, 
    type="l", xlab="", ylab="Power Sub Metering", col = "blue"))
legend("topright", lty= 1, col = c("Black", "red", "blue"), cex = 0.65,  xjust = 1, yjust = 1,
    legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot number 4 of 4
with(subsetDatafinal, plot(DateTime, Global_reactive_power, 
     type="l", xlab="Date Time", ylab="Global Reactive Power"))
dev.off()   