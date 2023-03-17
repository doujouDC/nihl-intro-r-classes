# Import some data
library(tidyverse)

sub_rna <- read_csv("./nihl-intro-r-classes-data-output/sub-rna.csv")

glimpse(sub_rna)

summary(sub_rna)

# Wrangle the Data

mean_exp_by_time <- sub_rna %>% 
  group_by(gene, time) %>% 
  summarize(mean_exp = mean(expression_log))

mean_exp_by_time %>% 
  ggplot(mapping = aes(x = time, y = mean_exp, color = gene)) +
  geom_line()


mean_exp_by_time %>% 
  ggplot(mapping = aes(x = time, y = mean_exp)) +
  geom_line() +
  facet_wrap(vars(gene), scales = "free_y")

mean_exp_by_time_sex <- sub_rna %>% 
  group_by(gene, time, sex) %>% 
  summarize(mean_exp = mean(expression_log))

mean_exp_by_time_sex

mean_exp_by_time_sex %>% 
  ggplot(mapping = aes(x = time, y = mean_exp, color = sex)) +
  geom_line() +
  facet_wrap(vars(gene), scales = "free_y")
  
  
  
  
  
  




