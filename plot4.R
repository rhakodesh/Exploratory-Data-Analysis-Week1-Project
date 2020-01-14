# PLOT 4

# 1. Set Working Directory
     setwd("D:/DS/R/Exploratory Data Analysis/WK1")

# 2. Reading Power Consumption Data
     power_data <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )

# 3. Creating a new column  with date and time merged together 
     date_time_merged <- strptime(paste(power_data$Date, power_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
     power_data <- cbind(power_data, date_time_merged)

# 4. Converting All Column Classes to desired Classes
     power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
     power_data$Time <- format(power_data$Time, format="%H:%M:%S")
     power_data$Global_active_power <- as.numeric(power_data$Global_active_power)
     power_data$Global_reactive_power <- as.numeric(power_data$Global_reactive_power)
     power_data$Voltage <- as.numeric(power_data$Voltage)
     power_data$Global_intensity <- as.numeric(power_data$Global_intensity)
     power_data$Sub_metering_1 <- as.numeric(power_data$Sub_metering_1)
     power_data$Sub_metering_2 <- as.numeric(power_data$Sub_metering_2)
     power_data$Sub_metering_3 <- as.numeric(power_data$Sub_metering_3)

# 5. Subsetting Power Data by the date
     subset_data <- subset(power_data, Date == "2007-02-01" | Date =="2007-02-02")

# 6. Plotting  the four in one graph
     png("plot4.png", width=480, height=480)
     par(mfrow=c(2,2))
     with(subset_data, plot(date_time_merged, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
     with(subset_data, plot(date_time_merged, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
     with(subset_data, plot(date_time_merged, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
     lines(subset_data$date_time_merged, subset_data$Sub_metering_2,type="l", col= "red")
     lines(subset_data$date_time_merged, subset_data$Sub_metering_3,type="l", col= "blue")
     legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
     with(subset_data, plot(date_time_merged, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
     dev.off()