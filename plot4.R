setwd("D:/Documents/Data Science/Week 13/exdata_data_household_power_consumption")
rdata <- read.table("D:/Documents/Data Science/Week 13/exdata_data_household_power_consumption/household_power_consumption.txt", 
                    header = TRUE,
                    sep = ";",
                    na.strings = "?")
Dates <- as.Date(rdata$Date, "%d/%m/%Y")
data <- data.frame(Dates,rdata[,2:9])
sdata <- split(data,data$Date)
a <- data.frame(sdata["2007-02-01"])
colnames(a) <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
b <- data.frame(sdata["2007-02-02"])
colnames(b) <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
pdata <- rbind(a,b)
x <- paste(pdata$Date,pdata$Time)
pdata$X <- as.POSIXct(x)
par(mfrow = c(2,2))
hist(pdata$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")
plot(pdata$X,
     pdata$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
plot(pdata$X,
     pdata$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(pdata$X,
      pdata$Sub_metering_2,
      col = "red")
lines(pdata$X,
      pdata$Sub_metering_3,
      col = "blue")
legend("topright", 
       col=c("black", "red", "blue"), 
       lty=1, 
       lwd=2,  
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(pdata$X,
     pdata$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.copy(png, file="plot4.png", height=480, width=480) 
dev.off() 