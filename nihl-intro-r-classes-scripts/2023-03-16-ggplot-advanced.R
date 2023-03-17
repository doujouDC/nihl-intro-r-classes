# Introduction to ggplot (advanced)

# Load our Packages
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(gapminder)
install.packages("tidyverse")

rna_fc <- read_csv("nihl-intro-r-classes-data-raw/rna-fc-short.csv")
glimpse(rna_fc)


rna_fc %>% 
  ggplot(mapping = aes(chromosome_name)) +
  geom_bar()


boxoffice_data <- read_csv("nihl-intro-r-classes-data-raw/domestic-boxoffice-weekend-2022-10-25.csv")

boxoffice_data %>% 
  filter(Rank <= 5) %>% 
  ggplot(mapping = aes(x = Release, y = Gross)) +
  geom_col(fill = "#20558A", width = 0.6) +
  # scale_x_discrete(guide = guide_axis(angle = 90))
  coord_flip()

rna_fc$expression_log <- as.numeric(rna_fc$expression_log)

str(rna_fc$expression_log)

mean_exp_over_time <- rna_fc %>% 
  group_by(gene, time) %>% 
  summarize(mean_exp = mean(expression_log))

mean_exp_over_time %>%
  ggplot(mapp)


