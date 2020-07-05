### Duplicate Regression for CUSP BIRDS

library(plyr)
library(tidyverse)
library(DBI)
library(fcr)
library(DT)
library(lubridate)
library(scales)
library(reshape2) ## melt
library(ggpubr)
library(zoo)
library(janitor)
library(skimr)
library(fcthemes)
library(hrbrthemes)
library(corrplot)
library(stargazer)
library(ggplot2)
library(GGally)
library(readr)



# Upload Data  ------------------------------------------------------------


df <- read_csv("C:/Users/mbh329/Documents/GitHub/cusp-bird-capstone/all_cleaned_wsp_sonyc_birds.csv") 
  
 
# output for html stargazer regression tables              
html_output_dir <- "C:/Users/mbh329/Documents/GitHub/cusp-bird-capstone/regression_table"

colnames(df)

## Get datatypes
sapply(df, class)






# Data Cleaning -----------------------------------------------------------
###lets convert the timestamp into datetime an extract year, month, week we will use these
### as factors in our regression to see if any time periods are highly correlated 

df1 <- df %>%
  mutate(year = lubridate::year(timestamp),
         month = lubridate::month(timestamp),
         week = lubridate::week(timestamp)) %>%
  plyr::rename(c("avg_mtr_#/km/h" = "avg_mtr_km_h",  "avg_mt_#/km" ="avg_mt_km")) %>%
#  mutate(sonyc_sensor_name = as.factor(sonyc_sensor_name),
#         year = as.factor(year),
#         month = as.factor(month),
#         week = as.factor(week)) %>%
  select(-sonyc_sensor_id)


sapply(df1, class)



# Summary Stats -----------------------------------------------------------

summary(df1)


cor_df1 <- df1 %>%
  select(-c(timestamp, sonyc_sensor_name))


cor_mtrx <- cor_df1 %>% cor()

cor_mtrx_viz <- corrplot(cor_mtrx, method = "circle")




# YAMNET Regression Model -------------------------------------------------


### Dependent variables is the pct positive YAMNET Predictions 

 dep_cols <- c(
   "Count of Positive Predictions" =  "count_of_positive_predictions",
   "Percent Postive Predictions" = "pct_positive_predictions"
 )
 
 
 base_formula <- "as.factor(sonyc_sensor_name) + l90 + avg_mtr_km_h + avg_mt_km +
                 avg_height_m + temp_celcius + dewp_celcius + rh_percentage + wind_dir +
                wind_speed_mph + sea_level_pressure_mb + precipitation_mm + 
               visibility_miles + gust_mph + peak_wind_gust_mph + as.factor(year) + 
               as.factor(month) + as.factor(week)"
 

 

# Yamnet Model 1 (No Norm)  -----------------------------------------------

    
 yamnet1 <- dep_cols %>% 
   map(~lm(str_glue("{.x} ~ {base_formula}"), 
           data = df1))

stargazer(yamnet1,
          type="html", 
          title = "Pct Positive Predictions Regrssion (Not Standardized)",
          column.labels = c("Count of Positive Predictions", "Percent Postive Predictions"),
          digits = 2,
          notes = str_glue("p<0.1 {x}; p<0.05 {x}{x}; p<0.01 {x}{x}{x}", .envir = list(x = "<sup>*</sup>")),
          notes.append = FALSE,
          model.numbers = FALSE,
          style = "jpam",
          out="capstone_bird_regression.html")





# Yamnet Model 2 (Standardized) ----------------------------------------------------

df1_s <- df1 %>%
  mutate_at(scale, .vars = vars(-c(timestamp, sonyc_sensor_name, year, month, week)))


yamnet2_s <- dep_cols %>% 
  map(~lm(str_glue("{.x} ~ {base_formula}"), 
          data = df1_s))
    
stargazer(yamnet2_s,
          type="html", 
          title = "Pct Positive Predictions Regrssion (Standardized)",
          column.labels = c("Count of Positive Predictions", "Percent Postive Predictions"),
          digits = 2,
          notes = str_glue("p<0.1 {x}; p<0.05 {x}{x}; p<0.01 {x}{x}{x}", .envir = list(x = "<sup>*</sup>")),
          notes.append = FALSE,
          model.numbers = FALSE,
          style = "jpam",
          out="capstone_bird_regression_standard.html")  




# Yamnet Model 3 (Z Transformation)  --------------------------------------


