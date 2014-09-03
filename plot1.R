#script to generate graphics for Assignment 1 in the 'Exploratory Data Analysis' course

#set the working directory
setwd("/Users/bart/Documents/R/Coursera/Cursus4")

#cleaning variables
rm(list=ls())

#read the unzipped txt-file and subset for 20070201 and 20070202
#inspired by the discussion forums
y <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';')
colnames(y) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
#original
#s <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings=c("",NA,"?"), stringsAsFactors = FALSE, colClasses = "character")
#y <- subset(s, Date == "1/2/2007" | Date == "2/2/2007")

#hist() needs a numeric input
y$Global_active_power <- as.numeric(y$Global_active_power)

#Create a DateTime column and store Date + Time fields combined
y$Date <- strptime(y$Date, "%d/%m/%Y")
y$DateTime <- paste(y$Date, y$Time, sep = " ")
y$DateTime <- strptime(y$DateTime,"%Y-%m-%d %H:%M:%S")

#plot to png-file and close
png("plot1.png",width=480,height=480,units='px')
hist(y$Global_active_power, col = "red", main = "Global active power", xlab = "Global active power (kilowatts)")
dev.off()

#end
