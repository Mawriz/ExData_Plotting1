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

## Plot number 1

png("plot1.png", width=480, height=480)
hist(subsetDatafinal$Global_active_power,
     main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)") 
dev.off()
