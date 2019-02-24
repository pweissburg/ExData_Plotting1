# Download file from interwebz (Mac)
download.file(destfile = "household_power_consumption.txt","https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",curls = TRUE)
# Read data into R from the WD
data <- as.tbl(read.table("household_power_consumption.txt",stringsAsFactors = FALSE,sep = ";",header = TRUE))
# Coerce date column from character to date
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
# Change columns 3:9 from character to numeric for plotting
data[3:9] <- data.matrix(data[3:9])
# Filter to only the two days worth of data required by the assignment
data2Days <- filter(data,Date == "2007-02-01" | Date == "2007-02-02")  
# Make the histogram
hist(data2Days$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)",breaks = 16)
# Copy to png device; default size is 480 px square
dev.copy(png,"plot1.png")
# Save to working directory
dev.off() 
