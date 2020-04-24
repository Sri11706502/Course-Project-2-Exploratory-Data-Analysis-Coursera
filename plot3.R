# This R script contains the code to plot png3.png
# The plot compares the Total Emissions over the Years for Baltimore City for different types of sources

# Loading the required libraries
library(dplyr)
library(ggplot2)


# Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Creating a subset for rows of Baltimore city(fips=24510)
NEI <- subset(NEI,fips=="24510")

# Creating a aggregate function for dividing the data based on year and type and then applying the sum function individually
Total <- aggregate(Emissions~year*type,NEI,sum)

# Opening the png file
png("png3.png")

# Drawing a bar plot with the help of ggplot2
# Defining aesthetics in ggplot function
ggplot(data=Total,
       aes(factor(year),
           Emissions,
           fill = type))+
  # Drawing a bar plot
  geom_bar(stat = "identity")+
  
  # Defing a multi panel plot ie, different panels for different type
  facet_grid(.~type)+
  
  # Defining the labels for axes and main title
  labs(x="Year",
       y="PM2.5 Emissions",
       title = "Emissions for Baltimore city for different types of sources",
       fill="Type")

# Closing the png device
dev.off()