# This R script contains the code to plot png2.png
# The plot compares the Total Emissions over the Years for Baltimore City


# Loading the required libraries
library(dplyr)

# Reading from the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Creating a subset for rows of Baltimore city(fips=24510)
NEI <- subset(NEI,fips=="24510")

# Creation of an aggregate function to split the data by years then apply sum function individually
balti <- aggregate(Emissions~year,NEI,sum)

# Opening a png file
png("png2.png")

#Creation of a bar plot
barplot(balti$Emissions,
        col = balti$year,
        names.arg = balti$year)
title(xlab="Years",
      ylab="PM2.5 Emissions",
      main="Total Emissions by Year for Baltimore City")

# Closing the png device
dev.off()