#######################################################################################

THIS DATA PACKAGE ACCOMPANIES: Functional Roles of the World's Recovered Predators, I. Shukla, J.A. Smith

This data package contains the original dataset as well as R code used to generate figures and analysis.

################################## CONTENTS ###########################################

Shukla et al. README.txt -- This file, including a description of variables.

Recovered_predators_dataset.csv -- A data file that includes the full list of community responses elicited by recovered predators

predator_recovery_code.R -- supplementary code of the generalized mixed linear model analysis, ordinal regression, and visualization for community response to predator recovery

#######################################################################################

VARIABLE NAMES AND DESCRIPTIONS

FILE: Recovered_predators_dataset.csv

id: Indicates an individual data point

Common name: Species common name

Latin name: Indicates species scientific name

Study_id: indicates data from a new or repeated study

Species_id: indicates a new or repeated species
 
Family: Species Taxonomic Family

Authors: Condensed citation of the lead author(s)

Year: Year that the article was published

Title: Title of the publication from which the species was sourced

Community_outcome: the specific ecological community response to the recovered predator

Response_ratio: Response ratio indicating the natural log of a community response without the recovered predator over the community response with the recovered predator

Variance: Variance for each calculation of response ratio

Category: The category of significant community change caused by predator absence/ decreased presence

Interaction: Whether the community response was a direct predation event (i.e. "density"), or behaviorally-mediated (i.e. "behavioral")

Type: Whether the predator recovered passively via dispersal or actively via translocation/ captive release

Mass: Raw mass of the predator (in grams)

Log_mass: logarithmically standardized predator mass

Apex: If the predator was the most dominant in the system ("Y"), or not ("N")

Time: The number of years between predator recovery and when the study took place

Consequences: Whether the community outcome was intended or unintended. "None" represents a passive predator recovery

Alignment: Whether the community outcome was aligned or not with local conservation goals

Lat: Latitude of the recovery site

Long: Longitude of the recovery site

Region: State/ province/ region where the recovery took place

Absence: The number of years in which the predator was locally extirpated 

Community Response: The category of significant community change caused by predator absence/ decreased presence

Log_gpd: the GDP (gross domestic product) of where the recovery took place, logarithmically standardized

governing_body: The governing body that managed the recovery

Predator: The existing predator species composition at the recovery site. "1" indicated no other predator species, "2" indicated one or more existing predator species

Prey: The existing prey composition at the recovery site. "1" indicated one prey species in the predator's diet, "2" indicated two or more prey species


#######################################################################################

ACKNOWLEDGEMENTS

This database was compiled by IS using published literature. Funding support for this research was provided by a Eugene Cota-Robles Fellowship (to IS).
