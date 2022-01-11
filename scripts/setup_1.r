library(magrittr)
library(tidyverse)

csc_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/MERGED2018_19_PP.csv"
csc_dict_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/csc_dictionary.csv"
out_path <- "C:/Code/GITHUB/csc/Accrediting-the-Accrediting-Agencies/data/csc.csv"
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

CollegeScorecard18 <- read_csv(csc_path,
                               na = c("", "NA", "NaN", "NULL",
                                      "Privacy Suppressed",
                                      "PrivacySuppressed") # nolint
                              ) %>%
                      mutate(PELLCAT = case_when(PCTPELL > .5 ~ 0,  # Majority percentage of the student population recieving a Pell grant # nolint
                                                 PCTPELL <= .5 ~ 1) # Minoirty percentage of the student population recieving a Pell grant # nolint
                            ) %>%
                      filter(!is.na(LATITUDE))

csc_dictionary <- read_csv(csc_dict_path)

csc <- CollegeScorecard18 %>% dplyr::select(UNITID, INSTNM, CITY, STABBR, ZIP, REGION,
                                     LOCALE, LATITUDE, LONGITUDE, ACCREDAGENCY,
                                     ACCREDCODE, MAIN, NUMBRANCH, PREDDEG, HIGHDEG, # nolint
                                     CONTROL, CCBASIC, CCUGPROF, CCSIZSET)

csc %>%
    group_by(ACCREDCODE) %>%
    summarise(num = n()) %>%
    view(title = "Agency Code Count")

csc %>%
    see_missing() %>%
    view(title = "missing data")

CollegeScorecard18 %>%
    see_missing() %>%
    filter(n > 0) %>%
    view(title = "nonmissing data")

nms <- CollegeScorecard18 %>%
    see_missing() %>%
    filter(n > 0) %>%
    dplyr::select(Variable)

csc <- CollegeScorecard18 %>% select(any_of(nms$Variable))

csc

csc_dictionary <- left_join(csc %>% see_missing(),
                            csc_dictionary,
                            by = "Variable")

write_csv(csc_dictionary, csc_dict_path)

write_csv(csc, out_path)













