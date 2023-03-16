# Basic Math Example

doug_example <- 8+8

# Load our Packages
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(gapminder)

# Explore our Data

names(gapminder)
glimpse(gapminder)
str(gapminder)

# Build the first plot layer using pipes

gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp))

# Build the first plot layer using base-R

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))


# Saving our base plot to an object
map1 <- gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp))

# Using our Plot Object to create our First Plot

map1 +
  geom_point()

# Playing around with fill and color in R
  
map2 <- gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, 
                       y = lifeExp, fill = continent))


# Playing around with fill and color in R + adding a plot
map2 +
  geom_point()


# Saving Our First Plot to an object to prepare for save
doug_plot <- map1 +
  geom_point()  


# Making Sure that Our Saved Plot Works
  doug_plot
  

# Doug saving the file to his project directory in the "nihl-intro-r-classes-fig-output"
  # folder
  
  ggsave("nihl-intro-r-classes-fig-output/doug-plot-01.svg", 
         plot = doug_plot, width = 11, height = 8.5,
         dpi = 300)
  
# Someone asked about adding multiple plots to the same basic recipe, this is one example

gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_hex(size = 1)

# Someone asked about adding multiple plots to the same basic recipe, this is another example

gapminder %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp)) +
  geom_point(size = 3, shape = 18, color = "#20558A",) +
  geom_smooth(method = "lm", se = TRUE, na.rm = TRUE)