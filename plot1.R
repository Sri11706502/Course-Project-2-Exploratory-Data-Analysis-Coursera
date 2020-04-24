# This R script contains the code to plot png1.png
# The plot compares the Total Emissions over the years in the United States


# Loading the required libraries
library(dplyr)

# Reading from the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate function to group by years and applying function sum individually
Total_Emissions <- aggregate(formula=Emissions~year,data=NEI,FUN = sum)

# Opening a png file
png("png1.png")

# Drawing box plot with the help of base plotting system
barplot(Total_Emissions$Emissions,
        col = Total_Emissions$year,
        names.arg = Total_Emissions$year)
title(xlab="Years",
      ylab="PM2.5 Emissions",
      main="Total Emissions over the years")

# Closing the png device
dev.off()
