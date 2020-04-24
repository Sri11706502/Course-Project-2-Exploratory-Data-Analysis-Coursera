# This R script contains the code to plot png4.png
# The plot compares the Total Emissions of Coal combustion over the years

# Loading the required libraries
library(dplyr)
library(data.table)
library(ggplot2)

# Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Converting to data.table format
NEI <- data.table(NEI)
SCC <- data.table(SCC)

# Creation of logical vectors where combusion is found
comb <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
# Creation of logical vectors where coal is found
coal <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE)

# Extraction of SCC values where combusion and coal are found
combSCC <- SCC[comb & coal, SCC]

# Extraction of data where SCC values of NEI match with Extracted SCC values where combusion and coal are found
combNEI <- NEI[NEI[,SCC] %in% combSCC]

# Opening png file
png("png4.png")

# Construction of ggplot
# Defining aesthetics in ggplot function
ggplot(combNEI,
       aes(factor(year),
           Emissions,
           fill=factor(year)))+
  
  # Barplot construction
  geom_bar(stat="identity")+
  
  # Defining labels for axes and main title
  labs(x="Years",
       y="Coal combustion PM2.5 Emissions",
       title = "Emissions from coal combustion over the years",
       fill="Year")

# Closing the png device
dev.off()