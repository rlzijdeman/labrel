# File: combine_data.R
# Purpose: create R-script that combines all data from local github repository
# Author: richard.zijdeman@iisg.nl
# Date: 2014-09-27
# Last change: none

# packages
library(RCurl)
library(lar)
library(xlsx)

# Change directory to your local copy of labrel github
setwd("/Users/richard/Documents/github/labrel/")

# Change directory to your download directory
download <- "/Users/richard/Downloads/labrel/"
giturl <- "https://raw.githubusercontent.com/rlzijdeman/labrel/master/data/"

#### Argentina ####
download.file(paste0(giturl, "Argentina/Argentina_1900_(RGM-July2011).xlsx"), 
              destfile = paste0(download, "argentina_1900.xlsx"), 
              method = "curl")
download.file(paste0(giturl, "Argentina/Argentina_2000_(RGM-July2011).xlsx"), 
              destfile = paste0(download, "argentina_2000.xlsx"), 
              method = "curl")

#### Bolivia ####
download.file(paste0(giturl, "Bolivia/Bolivia_1900_(RGM-June2011).xlsx"), 
              destfile = paste0(download, "bolivia_1900.xlsx"), 
              method = "curl")
download.file(paste0(giturl, "Bolivia/Bolivia_2000_(RGM-June2011).xlsx"), 
              destfile = paste0(download, "bolivia_2000.xlsx"), 
              method = "curl")

#### Brazil ####
download.file(paste0(giturl, "Brazil/Brazil_1650_(TB-June2011).xlsx"), 
              destfile = paste0(download, "brazil_1650.xlsx"), 
              method = "curl")
download.file(paste0(giturl, "Brazil/Brazil_1800_(TB-June2011).xlsx"), 
              destfile = paste0(download, "brazil_1800.xlsx"), 
              method = "curl")

#### Ceylon ####
download.file(paste0(giturl, "Ceylon/Ceylon_1650_(PdZ-June2011).xlsx"), 
              destfile = paste0(download, "ceylon_1800.xlsx"), 
              method = "curl")

#### China ####
download.file(paste0(giturl, "China/China_1500_(CMM-June2011).xlsx"), 
              destfile = paste0(download, "china_1500.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "China/China_1800_(CMM-June2011).xlsx"), 
              destfile = paste0(download, "china_1800.xlsx"), 
              method = "curl")

#### Italy ####
download.file(paste0(giturl, "Italy/Italy_1936_(AC-December2011)_kho.xlsx"),
              destfile = paste0(download, "italy_1900.xlsx"), 
              method = "curl")
              
download.file(paste0(giturl, "Italy/Italy_2001_(AC-December2011)_kho.xlsx"),
              destfile = paste0(download, "italy_2001.xlsx"), 
              method = "curl")

#### Japan ####
download.file(paste0(giturl, "Japan/Japan_1800_(CMM-June2011).xlsx"),
              destfile = paste0(download, "japan_1800.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Japan/Japan_2000_(CMM-June2011).xlsx"),
              destfile = paste0(download, "japan_2000.xlsx"), 
              method = "curl")

#### Java ####
download.file(paste0(giturl, "Java/Java_1650_(UB-June2011).xlsx"),
              destfile = paste0(download, "java_1650.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Java/Java_1800_(UB-June2011).xlsx"),
              destfile = paste0(download, "java_1800.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Java/Java_1900_(UB-June2011).xlsx"),
              destfile = paste0(download, "java_1900.xlsx"), 
              method = "curl")

#### Netherlands ####
download.file(paste0(giturl, "Netherlands/Netherlands_1900_(JvG-June2011).xlsx"),
              destfile = paste0(download, "netherlands_1900.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Netherlands/Netherlands_2000_(JvG-June2011).xlsx"),
              destfile = paste0(download, "netherlands_2000.xlsx"), 
              method = "curl")

#### Russia ####
download.file(paste0(giturl, "Russia/Russia_1500_(DK-June2011).xlsx"),
              destfile = paste0(download, "russia_1500.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Russia/Russia_1650_(DK-June2011).xlsx"),
              destfile = paste0(download, "russia_1650.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Russia/Russia_1800_(DK-June2011).xlsx"),
              destfile = paste0(download, "russia_1800.xlsx"), 
              method = "curl")
download.file(paste0(giturl, "Russia/Russia_1900_(GK-June2011).xlsx"),
              destfile = paste0(download, "russia_1900.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Russia/Russia_2000_(GK-June2011).xlsx"),
              destfile = paste0(download, "russia_2000.xlsx"), 
              method = "curl")

#### South_Africa ####
download.file(paste0(giturl, "South_Africa/SouthAfrica_2000_(BF-Nov2012).xlsx"),
              destfile = paste0(download, "southafrica_2000.xlsx"), 
              method = "curl")

#### Spain ####
download.file(paste0(giturl, "Spain/Spain_1800_(JMTL-Sept2011).xlsx"),
              destfile = paste0(download, "spain_1800.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Spain/Spain_1900_(JMTL-Sept2011).xlsx"),
              destfile = paste0(download, "spain_1900.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Spain/Spain_2000_(JMTL-Sept2011).xlsx"),
              destfile = paste0(download, "spain_2000.xlsx"), 
              method = "curl")

#### Taiwan ####
download.file(paste0(giturl, "Taiwan/Taiwan_1500_(CMM-June2011).xlsx"),
              destfile = paste0(download, "taiwan_1500.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Taiwan/Taiwan_1650_(CMM-June2011).xlsx"),
              destfile = paste0(download, "taiwan_1650.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Taiwan/Taiwan_1800_(CMM-June2011).xlsx"),
              destfile = paste0(download, "taiwan_1800.xlsx"), 
              method = "curl")

#### United States ####
download.file(paste0(giturl, "United_States/United_States_1800_(JV_July2012).xlsx"),
              destfile = paste0(download, "unitedstates_1800.xlsx"), 
              method = "curl")

#### Venice ####
download.file(paste0(giturl, "Venice/Venice_1500_(AC-December2011).xlsx"),
              destfile = paste0(download, "venice_1500.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Venice/Venice_1650_(AC-December2011).xlsx"),
              destfile = paste0(download, "venice_1650.xlsx"), 
              method = "curl")

download.file(paste0(giturl, "Venice/Venice_1800_(AC-December2011).xlsx"),
              destfile = paste0(download, "venice_1800.xlsx"), 
              method = "curl")







argentina.2000 <- read.lar(paste0(download, "argentina_2000.xlsx"))
draw.lar(lr.arg.2000)