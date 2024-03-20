here::i_am("code/01_data_cleaning.R")

pacman::p_load(tidyverse, 
               data.table,
               gtsummary, 
               kableExtra)

# List of pathogens we're visualizing data for
# and the surveillance systems they come from in the CDC dataset
pathogens = c("Flu", "RSV")
surveillance.systems = c("FluSurv-NET", "RSV-NET")

mmwr_weeks <- as.character(c(40:53, 1:18))

# Reading in the data for both datasets ----------------------------------------
flu = read.csv("data/raw/Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240215.csv") %>%
  filter(`Surveillance.Network` == surveillance.systems[1], 
         MMWR.Week %in% c(40:53, 1:18)) %>%
  mutate(MMWR.Week = factor(MMWR.Week, mmwr_weeks))

rsv = read.csv("data/raw/Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240215.csv") %>%
  filter(`Surveillance.Network` == surveillance.systems[2], 
         MMWR.Week %in% c(40:53, 1:18)) %>%
  mutate(MMWR.Week = factor(MMWR.Week, mmwr_weeks))

# RSV --------------------------------------------------------------------------

# Creating the race summary table
race_table <- rsv %>%
  filter(MMWR.Week == 18, Sex == "Overall", Site == "Overall", Age.group == "Overall") %>%
  select(Season, Race.Ethnicity, Cumulative.Rate) %>%
  arrange(Season, Race.Ethnicity) %>%
  rename(`Race Ethnicity` = Race.Ethnicity) %>%
  pivot_wider(names_from = Season, values_from = Cumulative.Rate) %>%
  mutate(`Race Ethnicity` = c("Asian/Pacific Islander",
                              "American Indian/Alaska Native",
                              "Black",
                              "Hispanic",
                              "Overall",
                              "White")) %>%
  mutate(`Race Ethnicity` = factor(`Race Ethnicity`,
                                   levels = c("Overall",
                                              "White",
                                              "Black",
                                              "Hispanic",
                                              "Asian/Pacific Islander",
                                              "American Indian/Alaska Native")
  )
  ) %>%
  arrange(`Race Ethnicity`)

# creating the age summary table
age_table <- rsv %>%
  filter(MMWR.Week == 18, Sex == "Overall", Site == "Overall", Race.Ethnicity == "Overall") %>%
  select(Season, Age.group, Cumulative.Rate) %>%
  arrange(Season, Age.group) %>%
  pivot_wider(names_from = Season, values_from = Cumulative.Rate) %>%
  mutate(Age.group = factor(Age.group, 
                            c("Overall", 
                              "0-17 years (Children)", "0-4 years", "0-<1 year", 
                              "1-4 years", "5-17 years", "5-11 years",
                              "12-17 years", "18+ years (Adults)", "18-49 years", 
                              "18-29 years", "30-39 years", "40-49 years",
                              "50-64 years", "65+ years", "65-74 years", 
                              "75+ years", "75-84 years", "85+ years"))) %>%
  arrange(Age.group) %>%
  rename(`Age Group` = Age.group)

# creating the overall epidemic trajectories by season plot
overall <- rsv %>% 
  filter(Sex == "Overall", Site == "Overall", 
         Race.Ethnicity == 'Overall', Age.group == "Overall")

message("Writing RSV Data")

write.csv(race_table, "data/rsv_race.csv")
write.csv(age_table, "data/rsv_age.csv")
write.csv(overall, "data/rsv_epicurve.csv")

# Flu --------------------------------------------------------------------------
# Creating the race summary table
race_table <- flu %>%
  filter(MMWR.Week == 18, Sex == "Overall", Site == "Overall", Age.group == "Overall") %>%
  select(Season, Race.Ethnicity, Cumulative.Rate) %>%
  arrange(Season, Race.Ethnicity) %>%
  rename(`Race Ethnicity` = Race.Ethnicity) %>%
  pivot_wider(names_from = Season, values_from = Cumulative.Rate) %>%
  mutate(`Race Ethnicity` = c("Asian/Pacific Islander",
                              "American Indian/Alaska Native",
                              "Black",
                              "Hispanic",
                              "Overall",
                              "White")) %>%
  mutate(`Race Ethnicity` = factor(`Race Ethnicity`,
                                   levels = c("Overall",
                                              "White",
                                              "Black",
                                              "Hispanic",
                                              "Asian/Pacific Islander",
                                              "American Indian/Alaska Native")
  )
  ) %>%
  arrange(`Race Ethnicity`)

# creating the age summary table
age_table <- flu %>%
  filter(MMWR.Week == 18, Sex == "Overall", Site == "Overall", Race.Ethnicity == "Overall") %>%
  select(Season, Age.group, Cumulative.Rate) %>%
  arrange(Season, Age.group) %>%
  pivot_wider(names_from = Season, values_from = Cumulative.Rate) %>%
  mutate(Age.group = factor(Age.group, 
                            c("Overall", 
                              "0-17 years (Children)", "0-4 years", "0-<1 year", 
                              "1-4 years", "5-17 years", "5-11 years",
                              "12-17 years", "18+ years (Adults)", "18-49 years", 
                              "18-29 years", "30-39 years", "40-49 years",
                              "50-64 years", "65+ years", "65-74 years", 
                              "75+ years", "75-84 years", "85+ years"))) %>%
  arrange(Age.group) %>%
  rename(`Age Group` = Age.group)

# creating the overall epidemic trajectories by season plot
overall <- flu %>% 
  filter(Sex == "Overall", Site == "Overall", 
         Race.Ethnicity == 'Overall', Age.group == "Overall")

message("Writing Flu Data")

write.csv(race_table, "data/flu_race.csv")
write.csv(age_table, "data/flu_age.csv")
write.csv(overall, "data/flu_epicurve.csv")

