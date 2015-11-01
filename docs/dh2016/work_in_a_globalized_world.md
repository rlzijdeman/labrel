# Work in a globalized world
## An allocation algorithm to add Labour Relations to digitised census data




# major points by reviewers in 2014
First, some of the complexities of the data collection and
organization could be brought out more clearly. At present, the authors do not
explore the theoretical implications of their dataset (e.g., objectivity,
cultural framing, changes in meaning over time) in ways that are common in the
digital humanities. 

more explanation could be offered for how this
dataset and accompanying taxonomy are useful for humanists. Though the major
trends are made clear from the treemaps, are there specific benefits that
(digital) humanists can anticipate from this work? If so, what are they and
what specific audiences would benefit from them.

I
would have liked to know a bit more about which algorithms were being used to
generate the tree-maps, as some of the them can be unstable. 


This paper shows an application of treemaps visualization to compare
(shifting) labor relations in a large international data set that has been
collaboratively accumulated through the use of a dedicated VRE (Virtual
Research Environment). 
- this is positive, but the VRE term may be of use

Unfortunately the (image of) this taxonomy is not embedded in this
document, and can't be judged; the cause of this omission is not known to me.

Even if this might be the first
application of treemaps in this specific field, treemaps as such are hardly
unknown of course. I am not convinced that the focus on treemaps alone
warrants a long paper presentation without further arguing on the
specialization of the treemap model for this specific type of research and its
methodological impact.

A
similar argument [not highlighting the VRE] can be given for the taxonomy used: a discussion on the
construction and methodological impact given the international setting, would
be interesting.



### to submit
Contemporary studies on social inequality often focus on income or status attainment, but neglect the fundamental underlying relationship between employer and employee, referred to as a 'labour relation'. This negligence of labour relations (for and with whom one works) was for a long time of no concern, as the employer-employee relationship was predominant in the period after World War II. However, the current fierce debate on the desirability of precarious work among the rising number of freelancers and independent contractors around the world, as well as the increased media attention and consumer awareness of 'forced labour' shows that employer-employee relationship is not a universal constant, but the result of a much broader historical context.

In order to identify changes in labour relations across time and to recognize global connections between these shifts, a taxonomy of labour relations covering the past five centuries was devised by the participants of the Global Collaboratory on the History of Labour Relations (https://collab.iisg.nl/web/LabourRelations/; Figure 1). This collaboratory – hosted by the International Institute of Social History in Amsterdam (http://www.socialhistory.org) – has grown in the past decade to an online scholarly community of dozens of regional experts across the world and from various scholarly disciplines, such as social and economic historians, archaeologists and sociologists. Using the taxonomy, accompanying codebook and guidelines for data entry, the global collaboratory has gathered data on labour relations for more than twenty countries, using five temporal cross-sections (1500, 1650, 1800, 1900, [Africa: 1950], 2000). Databases of many more countries and regions are currently being prepared. For each country and cross-section a set of scholarly products are created that consists of a predesigned database with 1) population and demographic data and 2) details of the labour relations. A methodological paper explaining the choices made in the data collection for each country and time period accompanies the database. Both the database and methodological paper are verified before they are provided online as open access publication.

Until now, most of the data gathered are manually derived from aggregated sources, such as occupational censuses, mainly for the period before 1800. The main aim of this paper is to present an alghorithm that was developed to automatically derive labour relations from digitized census materials. We therewith improve on the traditional way of working in the following ways. First, our alghorithm specifically applies to the biggest two projects that digitize census materials in the world NAPP and IPUMS, therewith providing a major contribution to the collection of labour relations for the post 1800 period and for the entire world. The second advantage our algorithm provides is that is able to derive labour relations from individual level census data, thus allowing for more rigorous tests of hypotheses on labour relations. For until now, labour relations have just been gathered from aggregated census tables, only allowing for national comparisons and hypothesis testing. By being able to attach labour relations to individuals, for the first time descriptive results on heterogeneity of labour relations within countries and over timer will become available. Moreover, researchers will be much more able to zoom in on the characteristics related to changes in labour relations, such as individual characteristics (e.g. age, gender, education), household composition (e.g. extended family, sibling composition), and historical context of the municipality, region or state (e.g. level of development, political orientation) and therefore be able to provide more rigorous tests of hypotheses on changes in labour relations. A third advantage of the algorithm is that it provides the first alternative derivation of labour relations and thus can be used to test the reliability of the traditional derivation of labour relations. For many of the digitized censuses both original aggregated tables as well as the individual level data have been preserved, thus allowing for a reliability check of both methods.


Our algorithm ... (RS, jouw ding hier)




### REST (NOT TO BE USED) 
This will thus not only lead to new descriptive results on heterogeneity in labour relations within countries and over time,
Supported by a grant from the Gerda Henkel Stiftung, in 2013 the project has started a second wave of data collection. In addition, the collaboratory now also focuses on analysis of the data retrieved so far. In particular major shifts in the history of labour relations worldwide are examined. This shift in the focus of the collaboratory also brings new challenges in the technical aspects of the project in terms of descriptive and explanatory data analysis.


##Treemap visualisations
First of all, since the taxonomy is a hierarchical entity and the data encompass dozens of countries and various time points, developments in labour relations are not easily summarised. A further complication is that one person might have multiple labour relations. We therefore propose graphical summaries of the data using Treemaps ([6]; [7]). Treemaps are especially designed to depict hierarchical relations in a small space. While treemaps have been successfully applied in economics, this is the first application of treemaps in the field of global history. Furthermore, while existing applications of treemaps often rely on commercial software, we utilise the recently released GPL-3, R package "Treemap" ([8]). Given the global collaboration among scholars involved in this project GPL software proves crucial since commercial licenses are not available to all research institutes. This applies especially to those scholars working in developing countries. For current examples, see Figure 2 and Figure 3.
A unique benefit of the treemaps is that they are able to deal with the fact that some persons hold multiple labour relationships. For example in Figure 2, the square indicated in yellow consists of all those persons who are wage earners for the market (nr. 14 in our taxonomy). While for some this is the only labour relation they hold, represented by the ‘empty square’, others have additional labour relations: leading producers (nr. 4) and servants (nr. 6).
Figure 3 shows how multiple treemaps can be used to chart regional differences and change over time in labour relations. Each row in Figure 3 represents a country, while every column represents a year. Due to the colour coding it is very easy to chart, for example, the decline over time in reciprocal labour relations in Russia, Spain and Italy. However, when comparing the countries column wise it is also evident that there are important country differences in the proportion of reciprocal labour relations at specific points in time. To sum up, our application of treemaps shows that they can be used to visually represent multiple hierarchical labour relations for a country at a given point in time, as well depict differences in those relations between different countries and changes over time.


##Extraction of census data
The second issue we address is the enormously time consuming effort of finding empirical evidence of (changes in) labour relations. While for earlier time periods this seems unavoidable, for the nineteenth and twentieth century various digitised sources are now available, such as from the North Atlantic Population Project (NAPP) ([9]) and the Integrated Public Use Microdata Series-International (IPUMS-I) ([10]). Both are based on censuses of various countries in the world. By translating and recoding the occupational taxonomies used in NAPP and IPUMS-I towards the labour relations taxonomy used by the Global Collaboratory, we have been able to semi-automatically include substantial amounts of new data to the existing collection.
The inclusion of the new data from the IPUMS and NAPP databases is immensely fruitful for various reasons. For one, we are able to describe labour relations for a wide selection of new countries across the globe for the nineteenth and twentieth century. Moreover, we will also be able to evaluate to what extent the evidence gathered in the first and second phase of data collection can be corroborated with this new source material. Finally, since some of the digitised census data are available for a ten year interval, we are able to see to what extent the choice for the temporal cross-sections, born out of necessity, can detect more subtle changes in labour relations throughout the late nineteenth and entire twentieth centuries. In the future, other repositories might be included as well in the data collection of the Global Collaboratory thus further enhancing both scope and sophistication of our methods to determine major shifts in the history of labour relations.
