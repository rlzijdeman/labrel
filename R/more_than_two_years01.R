# File: more_than_two_years01.R
# Date: 2014-10-29
# Author: richard.zijdeman@iisg.nl
# Last change: none so far

# set directory
setwd("/Users/richard/Documents/github/labrel/")

# load libraries
library("data.table")

# local github repository
load("./data/git_combine_data.Rda") # loads labrel.df into memory

# preserve data from labrel.df with more than 1 observation
all.dt <- data.table(labrel.df)
all.dt[, year.count := length(unique(bmyear)), by = country]
table(all.dt$year.count)

all.dt.2 <- all.dt[year.count >1, ]
all.dt.3 <- all.dt[year.count >2, ]
all.dt.4 <- all.dt[year.count >3, ]

write.csv(all.dt.2, file = "./data/git_combine_data_2yearsplus.csv")
write.csv(all.dt.3, file = "./data/git_combine_data_3yearsplus.csv")
write.csv(all.dt.4, file = "./data/git_combine_data_4yearsplus.csv")

# EOF


