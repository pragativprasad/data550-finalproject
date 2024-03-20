here::i_am("code/02_regression_analysis.R")

pacman::p_load(tidyverse, 
               data.table,
               gtsummary, 
               kableExtra)

# List of pathogens we're visualizing data for
# and the surveillance systems they come from in the CDC dataset
pathogens = c("Flu", "RSV")
surveillance.systems = c("FluSurv-NET", "RSV-NET")

mmwr_weeks <- as.character(c(40:53, 1:18))

#  Influenza Data Set creation -------------------------------------------------

flu_race = read.csv("data/raw/FluSurveillance_Custom_Download_Data_20240220.csv") %>%
  filter(MMWR.WEEK == 17, RACE.CATEGORY != "Overall", CATCHMENT != "Entire Network") %>%
  mutate(MMWR.WEEK = factor(MMWR.WEEK, mmwr_weeks),
         SEASON = as.character(YEAR),
         CUMULATIVE.RATE = as.numeric(CUMULATIVE.RATE),
         RACE.CATEGORY = factor(RACE.CATEGORY, levels = c("White", "Black",
                                                          "Hispanic/Latino",
                                                          "Asian/Pacific Islander",
                                                          "American Indian/Alaska Native")))

model_flu_race <- glm(data = flu_race, CUMULATIVE.RATE ~ RACE.CATEGORY, family = poisson(link = "log"))
message("Saving Race Regression Model - Flu")
saveRDS(model_flu_race, "output/model_flu_race.rds")

rsv_race = read.csv("data/raw/Rates_of_Laboratory-Confirmed_RSV__COVID-19__and_Flu_Hospitalizations_from_the_RESP-NET_Surveillance_Systems_20240215.csv") %>%
  filter(`Surveillance.Network` == surveillance.systems[2], 
         MMWR.Week == 18, Race.Ethnicity != "Overall") %>%
  mutate(MMWR.Week = factor(MMWR.Week, mmwr_weeks),
         Race.Ethnicity = factor(Race.Ethnicity, levels = c("White, non-Hispanic", "Black, non-Hispanic",
                                                            "Hispanic","A/PI, non-Hispanic",
                                                            "AI/AN, non-Hispanic")))

model_rsv_race <- glm(data = rsv_race, Cumulative.Rate ~ Race.Ethnicity, family = poisson(link = "log"))
message("Saving Race Regression Model - RSV")
saveRDS(model_rsv_race, "output/model_rsv_race.rds")
