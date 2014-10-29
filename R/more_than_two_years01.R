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
