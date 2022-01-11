library(magrittr)
library(tidyverse)

### Pathways
# Data files
program_offering_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/program_offering.csv" # nolint
act_sat_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/act_sat.csv" # nolint
geolocation_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/geolocation.csv" # nolint
outcomes_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/outcomes.csv" # nolint
student_population_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/student_population.csv" # nolint
institution_demographic_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/institution_demographic.csv" # nolint
misc_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/misc.csv" # nolint

# Dictionary files
program_offering_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/program_offering_dict.csv" # nolint
act_sat_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/act_sat_dict.csv" # nolint
geolocation_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/geolocation_dict.csv" # nolint
outcomes_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/outcomes_dict.csv" # nolint
student_population_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/student_population_dict.csv" # nolint
institution_demographic_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/institution_demographic_dict.csv" # nolint
misc_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/misc_dict.csv" # nolint

#############################################################################
#############################################################################

#### DATA IMPORT
#######################
# Import data
program_offering <- read_csv(program_offering_path)
act_sat <- read_csv(act_sat_path)
geolocation <- read_csv(geolocation_path)
outcomes <- read_csv(outcomes_path)
student_population <- read_csv(student_population_path)
institution_demographic <- read_csv(institution_demographic_path)
misc <- read_csv(misc_path)
#######################
program_offering
act_sat
geolocation
outcomes
student_population
institution_demographic
misc
#######################
#############################################################
#######################
# Import dictionary
program_offering_dict <- read_csv(program_offering_dict_path)
act_sat_dict <- read_csv(act_sat_dict_path)
geolocation_dict <- read_csv(geolocation_dict_path)
outcomes_dict <- read_csv(outcomes_dict_path)
student_population_dict <- read_csv(student_population_dict_path)
institution_demographic_dict <- read_csv(institution_demographic_dict_path)
misc_dict <- read_csv(misc_dict_path)
#######################
program_offering_dict
act_sat_dict
geolocation_dict
outcomes_dict
student_population_dict
institution_demographic_dict
misc_dict
#######################
program_offering_dict %>% view(title = "PROG_OFFER")
act_sat_dict %>% view(title = "ACT/SAT")
geolocation_dict %>% view(title = "GEOLOC")
outcomes_dict %>% view(title = "OUTCOMES")
student_population_dict %>% view(title = "STUD_POP")
institution_demographic_dict %>% view(title = "INST_DEMO")
misc_dict %>% view(title = "misc")
#######################
#############################################################

#############################################################################
#############################################################################

