#script to generate graphics for Assignment 1 in the 'Exploratory Data Analysis' course

#set the working directory
setwd("/Users/bart/Documents/R/Coursera/Cursus4")

#cleaning variables
rm(list=ls())

#plot created on a dutch version of OS X. 'do' = 'Thu', 'vr' = 'Fri', 'za' = 'Sat'.
#change locale
Sys.setlocale("LC_TIME", "C")

#read the unzipped txt-file and subset for 20070201 and 20070202
#inspired by the discussion forums
y <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';')
colnames(y) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
#original
#s <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings=c("",NA,"?"), stringsAsFactors = FALSE, colClasses = "character")
#y <- subset(s, Date == "1/2/2007" | Date == "2/2/2007")

#Create a DateTime column and store Date + Time fields combined
y$Date <- strptime(y$Date, "%d/%m/%Y")
y$DateTime <- paste(y$Date, y$Time, sep = " ")
y$DateTime <- strptime(y$DateTime,"%Y-%m-%d %H:%M:%S")

#plot to png-file and close
png("plot3.png",width=480,height=480,units='px')
with(y, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
lines (y$DateTime,y$Sub_metering_2,type = "l", col = "red")
lines(y$DateTime,y$Sub_metering_3,type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()

#end