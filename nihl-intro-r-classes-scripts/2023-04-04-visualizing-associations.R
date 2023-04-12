# 2022-04-04: Visualizing Associations

# Turn on our Packages

install.packages("report")

library(GGally)
library(tidyverse)
library(RColorBrewer)
library(openintro)
library(report)

# Create our Dataframe

blue_jays <- read_csv("nihl-intro-r-classes-data-raw/blue_jays.csv")


# First Histogram

blue_jays %>% 
  ggplot(mapping = aes(x = body_mass_g)) +
  geom_histogram(color = "black", fill = "white") +
  geom_vline(mapping = aes(xintercept = mean(body_mass_g, na.rm = TRUE)),
             color = "red")

blue_jays %>% 
  ggplot(mapping = aes(x = head_length_mm)) +
  geom_histogram(color = "black", fill = "white") +
  geom_vline(mapping = aes(xintercept = mean(head_length_mm, na.rm = TRUE)),
             color = "red")



blue_jays %>% 
  ggplot(mapping = aes(x = body_mass_g, y = head_length_mm)) +
  geom_point() +
  labs(
    y = "Head Length in Millimeters",
    x = "Body Mass in Grams"
  )

custom_color <- c("#FFC000", "#20558A")

blue_jays %>% 
  ggplot(mapping = aes(x = body_mass_g, y = head_length_mm, color = sex)) +
  geom_point(size = 1.5) +
  scale_color_brewer(palette = "Set1")
  labs(
    y = "Head Length in Millimeters",
    x = "Body Mass in Grams"
  )
  
mammals %>% 
  ggplot(mapping = aes(x = body_wt, y = brain_wt)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10")

mammals %>% 
  ggplot(mapping = aes(x = body_wt, y = brain_wt)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    x = "Body Weight",
    y = "Brain Weight"
  )

cor.test(blue_jays$body_mass_g, blue_jays$head_length_mm)


blue_jays %>% 
  ggplot(mapping = aes(x = body_mass_g, y = head_length_mm)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# Using Report Package
fit_blue_jays <- lm(data = blue_jays, head_length_mm~body_mass_g)

report(fit_blue_jays)

# Correlation Matrix (Correlogram)

blue_jay_matrix <- blue_jays %>% 
  select(head_length_mm, body_mass_g, skull_size_mm, sex)

# Draw our graph, and then we will talk about what this means 
  
ggpairs(data = blue_jay_matrix)

# Add a litle color using ggplot

ggpairs(data = blue_jay_matrix, ggplot2::aes(color = sex))

# ggcorr() function, allows to visualize the correlation of each pair of variable as tiles

blue_jay_matrix %>% 
  ggcorr(method = c("everything", "pearson"))

# A Bubble Chart is a multivariate graph that is a cross between a Scatterplot and a Proportional Area Chart.

blue_jays %>%
  ggplot(mapping = aes(x = body_mass_g, y = head_length_mm,
  size = skull_size_mm, color = sex)) +
  geom_point() +
  scale_size(range = c(.1, 5), name= "Skull Size (mm)") +
  facet_wrap(vars(sex)) +
  scale_color_brewer(palette="Set1") +
  labs(y = "Head length (mm)", 
       x = "Body mass (g)") +
  guides(col = FALSE) +
  theme(legend.position="bottom")
