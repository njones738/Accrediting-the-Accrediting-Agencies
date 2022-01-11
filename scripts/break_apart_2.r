library(magrittr)
library(tidyverse)

csc_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/csc_dictionary.csv" # nolint
csc_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/csc.csv" # nolint

#######################################################################
#######################################################################

#### FUNCTIONS

# R program for getting missing values
see_missing <- function(df) {
    as_tibble(lapply(df, function(x) sum(!is.na(x)))) %>%
            pivot_longer(cols = everything(),
                         names_to = "Variable",
                         values_to = "n"
                        ) %>%
            mutate(nmiss = max(n) - n,
                   n_pct = n / max(n),
                   nmiss_pct = nmiss / max(n))
                            }

#######################################################################
#######################################################################

#### DATA IMPORT

csc <- read_csv(csc_path) %>%
            select(-contains("POOLED"), -contains("SUPP"),
                   -contains("POOLYR"), -INSTURL, -NPCURL, -ALIAS)

csc_dictionary <- read_csv(csc_dict_path)
csc_dictionary %>% view(title = "Dictionary")

####################################################################
####################################################################

##################
# Parameters about the different programs offered by the institution
#       and the proportion of awards given in that program.
program_offering <- csc %>% select(UNITID, INSTNM, ACCREDCODE,
                                   contains("PCIP"), contains("BACHL"),
                                   contains("ASSOC"), contains("CERT1"),
                                   contains("CERT2"), contains("CERT4"))
program_offering_dict <- left_join(program_offering %>% see_missing() %>% select(Variable),
                                   csc_dictionary, by = "Variable")
##################
# Parameters about the admission rate and the institutions SAT/ACT scores
act_sat <- csc %>% select(UNITID, INSTNM, ACCREDCODE,
                          contains("ACT"), contains("SAT"),
                          ADM_RATE, ADM_RATE_ALL)
act_sat_dict <- left_join(act_sat %>% see_missing() %>% select(Variable),
                          csc_dictionary, by = "Variable")
##################
# Parameters about the geographic location of each institution
geolocation <- csc %>% select(UNITID, INSTNM, ACCREDCODE, CITY, ZIP,
                              STABBR, ST_FIPS, REGION, LOCALE,
                              LATITUDE, LONGITUDE)
geolocation_dict <- left_join(geolocation %>% see_missing() %>% select(Variable),
                              csc_dictionary, by = "Variable")
##################
# Parameters about student academic and loan outcomes 
outcomes <- csc %>% select(UNITID, INSTNM, ACCREDCODE,
                           contains("_4"), contains("_L4"),
                           contains("_PRIV"), contains("_PUB"),
                           contains("_MDN"), contains("_N"),
                           contains("_FTFT"), contains("_FTNFT"),
                           contains("_PTFT"), contains("_PTNFT"),
                           contains("_ALL"), contains("_FIRSTTIME"),
                           contains("_FULLTIME"), contains("_PARTTIME"),
                           contains("PLUS"), contains("DBRR"), contains("BBRR"),
                           CDR3, CDR3_DENOM, RET_FT4, RET_FTL4, RET_PT4, RET_PTL4, # nolint
                           LPSTAFFORD_CNT, LPSTAFFORD_AMT)
outcomes_dict <- left_join(outcomes %>% see_missing() %>% select(Variable),
                           csc_dictionary, by = "Variable")
##################
# Parameters about the student population
student_population <- csc %>% select(UNITID, INSTNM, ACCREDCODE, contains("UGDS"),
                                     PPTUG_EF, PFTFTUG1_EF, UGNONDS,
                                     GRADS, PCTPELL, FTFTPCTPELL, FTFTPCTFLOAN,
                                     UG12MN, G12MN, SCUGFFN, D_PCTPELL_PCTFLOAN)
student_population_dict <- left_join(student_population %>% see_missing() %>% select(Variable),
                                     csc_dictionary, by = "Variable")
##################
# Parameters about the institution demographics
institution_demographic <- csc %>% select(UNITID, INSTNM, ACCREDAGENCY, ACCREDCODE, # nolint
                                          HCM2, MAIN, NUMBRANCH, PREDDEG, HIGHDEG, # nolint
                                          CONTROL, CURROPER, COSTT4_A, COSTT4_P,
                                          TUITIONFEE_IN, TUITIONFEE_OUT, TUITIONFEE_PROG, # nolint
                                          TUITFTE, INEXPFTE, AVGFACSAL, PFTFAC, ICLEVEL, # nolint
                                          T4APPROVALDATE, OPENADMP, OPEFLAG, SCHTYPE, PRGMOFR, # nolint
                                          CCBASIC, CCUGPROF, CCSIZSET,
                                          HBCU, PBI, ANNHI, TRIBAL, AANAPII, HSI, # nolint
                                          NANTI, MENONLY, WOMENONLY, RELAFFIL, DISTANCEONLY) # nolint
institution_demographic_dict <- left_join(institution_demographic %>%
                                                         see_missing() %>%
                                                         select(Variable),
                                          csc_dictionary, by = "Variable")
##################
# Miscellaneous parameters
misc <- csc %>%
    select(-contains("PCIP"), -contains("BACHL"), -contains("ASSOC"),
           -contains("CERT1"), -contains("CERT2"), -contains("CERT4"),
           -contains("ACT"), -contains("SAT"),
           -contains("_4"), -contains("_L4"), -contains("UGDS"),
           -contains("_PRIV"), -contains("_PUB"),
           -contains("_MDN"), -contains("_N"),
           -contains("_FTFT"), -contains("_FTNFT"),
           -contains("_PTFT"), -contains("_PTNFT"),
           -contains("PLUS"), -contains("DBRR"), -contains("BBRR"),
           -contains("_ALL"), -contains("_FIRSTTIME"),
           -contains("_FULLTIME"), -contains("_PARTTIME"),
           -ADM_RATE, -ADM_RATE_ALL, -CITY, -ZIP, -LOCALE,
           -STABBR, -ST_FIPS, -REGION, -LATITUDE, -LONGITUDE,
           -RET_FT4, -RET_FTL4, -RET_PT4, -RET_PTL4, -SCUGFFN,
           -PPTUG_EF, -PFTFTUG1_EF, -UGNONDS, -GRADS,
           -PCTPELL, -PCTFLOAN, -FTFTPCTPELL, -FTFTPCTFLOAN,
           -UG12MN, -G12MN, -LPSTAFFORD_CNT, -LPSTAFFORD_AMT,
           -CCBASIC, -CCUGPROF, -CCSIZSET, -D_PCTPELL_PCTFLOAN,
           -HBCU, -PBI, -ANNHI, -TRIBAL, -AANAPII, -HSI, 
           -NANTI, -MENONLY, -WOMENONLY, -RELAFFIL, -DISTANCEONLY,
           -ACCREDAGENCY, -CDR3, -CDR3_DENOM, 
           -HCM2, -MAIN, -NUMBRANCH, -PREDDEG, -HIGHDEG,
           -CONTROL, -CURROPER, -COSTT4_A, -COSTT4_P,
           -TUITIONFEE_IN, -TUITIONFEE_OUT, -TUITIONFEE_PROG,
           -TUITFTE, -INEXPFTE, -AVGFACSAL, -PFTFAC, -ICLEVEL,
           -T4APPROVALDATE, -OPENADMP, -OPEFLAG, -SCHTYPE, -PRGMOFR
           )
misc_dict <- left_join(misc %>% see_missing() %>% select(Variable),
                       csc_dictionary, by = "Variable")
####################################################################
####################################################################

#################################################################
program_offering
act_sat
geolocation
outcomes
student_population
institution_demographic
misc

program_offering_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/program_offering.csv" # nolint
act_sat_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/act_sat.csv" # nolint
geolocation_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/geolocation.csv" # nolint
outcomes_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/outcomes.csv" # nolint
student_population_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/student_population.csv" # nolint
institution_demographic_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/institution_demographic.csv" # nolint
misc_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/subdatasets/misc.csv" # nolint

write_csv(program_offering, program_offering_path)
write_csv(act_sat, act_sat_path)
write_csv(geolocation, geolocation_path)
write_csv(outcomes, outcomes_path)
write_csv(student_population, student_population_path)
write_csv(institution_demographic, institution_demographic_path)
write_csv(misc, misc_path)
#################################################################
program_offering_dict
act_sat_dict
geolocation_dict
outcomes_dict
student_population_dict
institution_demographic_dict
misc_dict

program_offering_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/program_offering_dict.csv" # nolint
act_sat_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/act_sat_dict.csv" # nolint
geolocation_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/geolocation_dict.csv" # nolint
outcomes_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/outcomes_dict.csv" # nolint
student_population_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/student_population_dict.csv" # nolint
institution_demographic_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/institution_demographic_dict.csv" # nolint
misc_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/dictionaries/misc_dict.csv" # nolint

write_csv(program_offering_dict, program_offering_dict_path)
write_csv(act_sat_dict, act_sat_dict_path)
write_csv(geolocation_dict, geolocation_dict_path)
write_csv(outcomes_dict, outcomes_dict_path)
write_csv(student_population_dict, student_population_dict_path)
write_csv(institution_demographic_dict, institution_demographic_dict_path)
write_csv(misc_dict, misc_dict_path)
#################################################################