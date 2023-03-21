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
  
  
  mean_exp_plot <- mean_exp_by_time_sex %>% 
    ggplot(mapping = aes(x = time, y = mean_exp, color = sex))
  
  
# Start customizing my plot
 
mean_exp_plot +
  geom_line() +
  facet_wrap(vars(gene), scales = "free_y") +
  labs(
    title = "Mean gene expression by duration of time of infection",
    x = "Duration of infection (in days)",
    y = "Mean gene expression"
  )
  
mean_exp_plot +
  geom_line() +
  facet_wrap(vars(gene), scales = "free_y") +
  labs(
    title = "Mean gene expression by duration of time of infection",
    x = "Duration of infection (in days)",
    y = "Mean gene expression"
  ) +
  theme(
    panel.grid = element_blank()
  ) +
  theme(text = element_text(size = 10))
  
mean_exp_plot +
  geom_line() +
  facet_wrap(vars(gene), scales = "free_y") +
  labs(
    title = "Mean gene expression by duration of time of infection",
    x = "Duration of infection (in days)",
    y = "Mean gene expression"
  ) +
  theme(
    panel.grid = element_blank()
  ) +
theme(
  axis.text.x = element_text(size = 11),
  axis.text.y = element_text(size = 11),
  # legend.position = "top"
)

# Arranging Our Plots

# Make our base plot

sub_rna_base_plot <- sub_rna %>% 
  ggplot(mapping = aes(y = expression_log, x = as.factor(time)))

# Box Plot

sub_rna_base_plot_boxplot <- sub_rna_base_plot +
  geom_boxplot() +
  facet_wrap(vars(sex))

# Violin Plot

sub_rna_base_plot_violin <- sub_rna_base_plot +
  geom_violin() +
  facet_wrap(vars(sex))

# Create a simple bar plot

sub_rna_base_plot_barplot <- sub_rna %>%
  ggplot(mapping = aes(chromosome_name)) +
  geom_bar()

# Install and load our Packages

install.packages("patchwork")
library(patchwork)

# Arrange Side by Side

sub_rna_base_plot_boxplot + sub_rna_base_plot_violin

# Arrange Top to Bottom
sub_rna_base_plot_boxplot / sub_rna_base_plot_violin

# More complex design

sub_rna_base_plot_barplot +
  (sub_rna_base_plot_boxplot + sub_rna_base_plot_violin) +
  plot_layout(ncol = 1)
  
  
  
  
  



