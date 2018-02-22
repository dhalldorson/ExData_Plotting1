plot2<- function() {
##******************************************************************************
##This function reads in the household power consumption data, filters for the 
##two dates required and creates the plot in a png file. 
##
##Requirements:
##   Data file household_power_consuption.txt has already been downloaded and
##   unzipped in the current working directory. 
##Dependencies:
##   dplyr and lubridate are already installed
##******************************************************************************
##Load libraries
library(dplyr)
library(lubridate)
##Read in the entire file
hpc<-read.table('household_power_consumption.txt', header=TRUE, sep=";", 
                stringsAsFactors = FALSE, na.strings="?", 
                col.names=c("Date","Time","globalactivepower", "globalreactivepower","voltage", 
                            "globalintensity","submetering1","submetering2","submetering3"))
hpc<-tbl_df(hpc)
##Filter for the two dates needed and create a new variable for the DateTime
hpc<-filter(hpc, (Date=="1/2/2007")|(Date=="2/2/2007"))
#'hpc$Date<-dmy(hpc$Date)
hpc<-mutate(hpc, DateTime=dmy_hms(paste(hpc$Date, hpc$Time)))

##Open the graphics device, generate plot, and close the device
##Plot2
png(filename="plot2.png")
with(hpc, plot(DateTime, globalactivepower, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
}