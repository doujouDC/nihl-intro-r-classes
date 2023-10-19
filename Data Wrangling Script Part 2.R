##Data Wrangling in R: Part 2##
##June 16, 2023##
##Candace Norton##



##Install tidyverse.##
##Ctrl + enter = run commands from script##
install.packages("tidyverse")



##load tidyverse.##
library(tidyverse)



##read in surveys.csv file##
##assignment operator uses alt + -##

##tab to auto complete commands and highlight folder## 
##names and files within the project##
surveys <- read_csv("data/surveys.csv")





##Where we left off in Part 1...##

##Combining select() and filter() to refine your data set##
##Use Ctrl+Shift+M to generate pipe symbol##
surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)




##Use mutate() to create a new column from existing data## 
##by performing a calculation or other command##
surveys %>%
  mutate(weight_kg = weight / 1000)




##create a second new column based on the first new column 
##within the same call of mutate()##
surveys %>%
  mutate(weight_kg = weight / 1000,
         weight_lb = weight_kg * 2.2)



##Use head() for a more concise view of the first few rows##
##head() defaults to showing the first 6 rows; 
##can be customized to show more or less##
surveys %>%
  mutate(weight_kg = weight / 1000) %>%
  head()



##is.na() is a function that determines whether something is an NA##
##The ! symbol negates the result, thus asking for every row 
##where weight is not an NA##

##The first few rows of the output are full of NAs; 
##to remove those insert a filter() in the chain##
surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000) %>%
  head()



##Assign the filtered data to a new object##
surveys_partial <- surveys %>%
  filter(!is.na(weight),
         !is.na(hindfoot_length), 
         !is.na(sex))






##Introducing group_by() and summarize()##

##group_by() can be used to take one or more column names 
#(aka variables) and select those groups in anticipation of 
#performing another action like summarize()##

##summarize() takes the group(s) created by group_by() and generates 
#summary statistics##

##In this example,group_by() is identifying the column "sex", 
#and summarize() is creating a new summary value named mean_weight 
#by calcuting the mean of the values in "weight", grouped by 
#the associated values for "sex"## 

surveys_partial %>%
  group_by(sex) %>%
  summarize(mean_weight= mean(weight, na.rm = TRUE))









##group_by() can be used on multiple columns at once and then 
#combined with summarize()##

##In this example, we're grouping the mean weights by both sex 
#and species.##

##The resulting output can be hard to read in its entirety, 
#so we use tail() to show only the final 6 rows. 
#tail() is the complement to head(), introduced in Part 1##

surveys_partial %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = 	TRUE)) %>%
  head()










##arrange() is used to force a particular sort order.##

##In this example, we're adding an additional summary 
#statistic to our summarize() call, min_weight##

##We will use the arrange() function to force a sort order 
#based on the new value min_weight##

surveys_partial %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>%
  arrange(min_weight)










##We can use a single function count() to replace the 
#combined functions group_by() and summarize(), if the output 
#we're interested in is based on counting observations##

##Simplified group_by() and summarize() example followed by 
#the same example using count()##

surveys_partial %>%
  group_by(sex) %>%
  summarize(count = n())


surveys_partial %>%
  count(sex)











##We can also combine count() with arrange() to force the output 
#to sort in a particular way for easier comparison##

surveys_partial %>%
  count(sex, species_id) %>%
  arrange(species_id, desc(n))


str(surveys_partial)









##Question: How many animals were caught in each plot_id surveyed?

surveys_partial %>% 
  count(plot_id)











##Question: What was the heaviest animal measured in each year? 
#Return the columns year, species_id, and weight.


surveys_partial %>% 
  group_by(year) %>% 
  filter(weight==max(weight)) %>% 
  select(year, species_id, weight) %>% 
  arrange(year)



















##Exporting Data##

##Let’s start by removing observations of animals for which weight and 
#hindfoot_length are missing, or the sex has not been determined:

surveys_complete <- surveys_partial %>%
  filter(!is.na(weight),           # remove missing weight
         !is.na(hindfoot_length),  # remove missing hindfoot_length
         !is.na(sex))                # remove missing sex













##Now that our data set is ready, we can save it as a CSV file 
#in our data folder.
write_csv(surveys_complete, file = "data/surveys_complete.csv")





















