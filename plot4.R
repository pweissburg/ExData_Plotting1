# Download file from interwebz (Mac)
download.file(destfile = "household_power_consumption.txt","https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",curls = TRUE)
#Read data into R from the WD
data <- as.tbl(read.table("household_power_consumption.txt",stringsAsFactors = FALSE,sep = ";",header = TRUE))
# Coerce date column from character to date
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
# Change columns 3:9 from character to numeric for plotting
data[3:9] <- data.matrix(data[3:9])
# Filter to only the two days worth of data required by the assignment
data2Days <- filter(data,Date == "2007-02-01" | Date == "2007-02-02") 
# Eliminate NAs
data2Days2 <- filter(data2Days,complete.cases(data2Days) == TRUE)
# Concatentate Date and Time columns using lubridate::ymd_hms and add that as a column with dplyr::mutate
data3 <- mutate(data2Days2,date.time = ymd_hms(paste(data2Days2$Date,data2Days2$Time,sep = " ")))

# Plot 1
# Set parameters for multiple plots on 1 device:
par(mfrow = c(2,2))
# Add first plot with no points:
plot(data3$date.time,data3$Global_active_power,ylab = "Global Active Power (kilowatts)",xlab = "",type = "n")
# Add lines:
lines(data3$date.time,data3$Global_active_power)

# Plot 2
# Add plot with no points:
plot(data3$date.time,data3$Voltage,ylab = "Voltage",xlab = "datetime",ylim = c(233,247),type = "n")
# Add lines:
lines(data3$date.time,data3$Voltage)

# Plot 3
# Add plot with no points:
plot(data3$date.time,data3$Sub_metering_1,type="n",ylab = "Energy sub metering",xlab = "")
# Plot data series 1
lines(data3$date.time,data3$Sub_metering_1,col = "black")
# Plot data series 2
lines(data3$date.time,data3$Sub_metering_2,col = "red")
# Plot data series 3
lines(data3$date.time,data3$Sub_metering_3,col = "blue")
# Add legend
legend("topright",pch = "--",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")

# Plot 4
# Add plot with no points:
plot(data3$date.time,data3$Global_reactive_power,ylab = "Global_reactive_power",xlab = "datetime",type = "n")
# Add lines:
lines(data3$date.time,data3$Global_reactive_power)

# Copy to png device; default size is 480px square
dev.copy(png,"plot4.png")
# Save to working directory; close png device
dev.off()