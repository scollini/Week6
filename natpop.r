library(historydata)
help(package = historydata)
library(dplyr)
install.packages("tidyr")
devtools::install_github("hadley/tidyr")
library(tidyr)
library(lubridate)

state <- read.csv("~/Desktop/Clio-3/Week6/historydata/data-raw/nhgis0011_ts_state.csv", stringsAsFactors = FALSE)

nat_pop <- state %>%
  group_by(YEAR) %>%
  summarize(Population = sum(A00AA, na.rm = TRUE))









