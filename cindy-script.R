library(tidyverse)
surveys <- read_csv("./raw-data/combined.csv")
str(surveys)

surveys$plot_type <- factor(surveys$plot_type)

surveys$taxa <- factor(surveys$taxa)

taxa <- surveys$taxa
head(taxa)
levels(taxa)
table(taxa)
plot(taxa)
