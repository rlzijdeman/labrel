labrel
======

##Labour relations

This github site is used as a data repository for the [Global Collaboratory on the History of Labour Relations](https:/collab.iisg.nl/web/LabourRelations/) (GCHLR) as well as to keep track of status of current files and todo's. 


###Data
Data on labour relations are provided in the data directory. These data are offically released, while pre-released data of other countries and time periods is available from the [GCHLR](https:/collab.iisg.nl/web/LabourRelations/). Data are accompanied by methodological papers, explaining issues, assumptions and decisions made in the process of creating the data. Use of the data is permitted under the terms and conditions as specified in the license agreement provided in the main directory.

###Issues and requests
We welcome suggestions for improvements, donation of datasets on labour relations, as well as requests for new features. On github, these are all considered 'issues' and anyone can file such an issue, if you're logged in with your github account.

### Interactive viewer of labour relations
The [larApp](http://node-128.dev.socialhistoryservices.org:443/larApp/) is an online interactive viewer of labour relations. The viewer allows one to view the labour relations by country and time period.

### R
Various tools have been developed to work with the labour relations in R. For one, the interactive viewer is a Shiny application, based on R. In addition, there is a specific package [lar](http://cran.r-project.org/web/packages/lar/index.html) which allows one to read in and visualize labour relations. For example, to download, read and display the labour relations in Argentina in 2000, run the following code:

```{r}
require(RCurl)
require(xlsx)
require(lar)

download.file("https://raw.githubusercontent.com/rlzijdeman/labrel/master/data/Argentina/Argentina_2000_(RGM-July2011).xlsx", 
              destfile = "./argentina_2000.xlsx", method = "curl")
lr.arg.2000 <- read.lar("argentina_2000.xlsx")
draw.lar(lr.arg.2000)
```
 
