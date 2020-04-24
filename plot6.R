# This R script contains the code to plot png5.png
# The plot compares the Total Emissions of Coal combustion over the years

# Loading the required libraries
library(dplyr)
library(data.table)

# Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Converting data.frame into data.table format
NEI <- data.table(NEI)
SCC <- data.table(SCC)

# Creation of a logical vector which returns true if vehicle is found in column
vehi <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)

# Extraction of SCC numbers where vehicle substring was found
vehiSCC <- SCC[vehi, SCC]

# Extracting rows where SCC values of NEI and Extracted SCC values match
vehiNEI <- NEI[NEI[,SCC] %in% vehiSCC]

# Extracting rows for Baltimore city(fips=24510)
vehiNEI_B <- subset(vehiNEI,fips=="24510")
# Extracting rows for Los Angeles city(fips=06037)
vehiNEI_L <- subset(vehiNEI,fips=="06037")

# Merging both subsets of city into one
Final <- rbind(vehiNEI_L,vehiNEI_B)

# Adding labels to the levels for labelling the panels in plot
Final$fips <- factor(Final$fips,levels = c("06037","24510"),
                     labels = c("Los Angeles","Baltimore"))

# Opening a png file
png("png6.png")

# Construction of plot using ggplot2
# Defing aesthetics in ggplot function
ggplot(Final,
       aes(factor(year),
           Emissions,
           fill=factor(year)))+
  
  # Barplot construction
  geom_bar(stat="identity")+
  
  # Different panels for different cities
  facet_grid(.~fips)+
  
  # Defining labels for axes and main title
  labs(x="Years",
       y="Vehicle PM2.5 Emissions",
       title = "PM2.5 Emissions from Vehicle over the years in Baltimore City" ,
       fill="Year")

# Closing the png device
dev.off()