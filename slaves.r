library(dplyr)
library(ggplot2)
install.packages("tidyr")
devtools::install_github("hadley/tidyr")
library(tidyr)
library(lubridate)

slaves <- read.csv("~/Desktop/MountVernon/Spreadsheets/slaves.csv", stringsAsFactors = FALSE)

## This function shows all the children during each census
slave_children <- slaves %>% 
  select(Name, Gender, Birth.Year, Skill, Farm, Census) %>%
  filter(Skill == "Child")
## This chart shows the number of children on each farm for 1786 and 1799. Ferry Farm evolved into Union Farm, 
## which the chart illustrates. Every farm had more children, especially Muddy Hole and Mansion House. 
ggplot(data = slave_children, aes(x = Farm, stat = "identity")) + geom_bar() + facet_wrap(~Census) + theme(axis.text.x=element_text(angle = 90, hjust = 0))
## This chart shows the number of children born on each farm during each birth year listed on the census. It's misleading, because 
## it also shows the counts of unknown birth years. The dates are also not standardized in the original spreadsheet.
ggplot(data = slave_children, aes(x = Birth.Year, na.rm = TRUE, stat = "identity")) + geom_bar() + facet_wrap(~ Farm) + theme(axis.text.x=element_text(angle = 90, hjust = 0))
## This chart led me to consider the number of children (with a birth year) born on the entire estate over time. Of couse, this also is misleading,
## because a number of children do not have birth years on the census. 
slave_br <- slaves %>%
  filter(Skill == "Child") %>%
  group_by(Birth.Year) %>%
  summarize(Name = n())

## This chart attempts to show the slave population on the estate per census, but the spreadsheet lists overlapping census dates 
## and they're not standardized. 
slave_pop <- slaves%>%
  group_by(Census)%>%
  summarize(Name = n())
## This function keeps returning errors in the data fram. With the the slave_pop dataframe 
## I wanted to then mutate the slave birth rate per farm. 
ggplot(data = slave_pop, aes(x = Census, y = n)) + geom_line() + theme(axis.text.x=element_text(angle = 90, hjust = 0))

## This table shows the number of children born to each mother. 
slave_mothers <- slaves %>%
  group_by(Mother) %>%
  summarize(Name = n())

ggplot(data = slave_mothers, aes(x = Mother, y = n)) + geom_bar() + theme(axis.text.x=element_text(angle = 90, hjust = 0))

## It would be interesting to compare the distribution of spouses across the estate. Slaves could not legally marry, so it's
## interesting anyway that Washington listed slave spouses. With this new table, I wanted to see how many slave couples were on 
## the same farm or on different farms. I then want to compare that finding to their children. 
slave_spouses <- slaves %>%
  select(Name, Spouse, Farm) 
## With this table, you can see that not every mother had a spouse. I wanted to break this table down into each main farm
## but I'm finding it difficult. 
slave_fam <- slaves %>%
  select(Name, Spouse, Mother, Siblings, Farm) 

## I tried to separate out each census year. 
slaves_sep <- slaves %>%
  separate(Census, c("1743", "1750", "1752", "1754", "1757", "1762", "1763", "1764", "1772" "1786", "1799"))

# I will change the census years with () to just numbers.
Census <- c("(1799)" = "1799")
# I will then try to standardize the birth years, such as removing the ()s. 
Birth.Year <- c("1729 (1799)" = "1729")



