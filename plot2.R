# Download file from interwebz (Mac)
download.file(destfile = "household_power_consumption.txt","https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",curls = TRUE)
# Read data into R from the WD
data <- as.tbl(read.table("household_power_consumption.txt",stringsAsFactors = FALSE,sep = ";",header = TRUE))
# Coerce date column from character to date
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")N
# Change columns 3:9 from character to numeric for plotting
data[3:9] <- data.matrix(data[3:9])
# Filter to only the two days worth of data required by the assignment
data2Days <- filter(data,Date == "2007-02-01" | Date == "2007-02-02") 
# Eliminate NAs
data2Days2 <- filter(data2Days,complete.cases(data2Days) == TRUE)
# Concatentate Date and Time columns using lubridate::ymd_hms and add that as a column with dplyr::mutate
data3 <- mutate(data2Days2,date.time = ymd_hms(paste(data2Days2$Date,data2Days2$Time,sep = " ")))
# Plot with no points
plot(data3$date.time,data3$Global_active_power,ylab = "Global Active Power (kilowatts)",xlab = "",type = "n")
# Add lines
lines(data3$date.time,data3$Global_active_power)
# Copy to png device; default size is 480px square
dev.copy(png,"plot2.png")
# Save to working directory; close png device
dev.off()