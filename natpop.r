library(historydata)
help(package = historydata)
library(dplyr)
install.packages("tidyr")
devtools::install_github("hadley/tidyr")
library(tidyr)
library(lubridate)

state <- read.csv("~/Desktop/Clio-3/Week6/historydata/data-raw/nhgis0011_ts_state.csv", stringsAsFactors = FALSE)

nat_pop <- state %>% ## Create a new name for the table
  group_by(YEAR) %>% ## Group each different census year together from the state csv 
  summarize(Population = sum(A00AA, na.rm = TRUE)) ## Then sum up each state population for that census









