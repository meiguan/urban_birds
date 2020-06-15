### cleaning nexrad scans into csv files
### run this file from terminal using 
### source("~/urban_birds/clean/clean_nexrad.R")
library(bioRad, quietly = T)
library(Hmisc, quietly = T)
HOME = '/gws_gpfs/projects/project-urban_birds/workspace' # this is unique
file.exists(HOME)
setwd(HOME)
# set session time zone to UTC
Sys.setenv(TZ = "UTC")

files <- c('KDIX2016night.RData', 'KDIX2017night.RData', 'KDIX2018night.RData', 'KDIX2019night.RData',
          'KOKX2016night.RData', 'KOKX2017night.RData', 'KOKX2018night.RData', 'KOKX2019night.RData', 
          'KOKX_spring_2020.RData', 'KDIX_spring_2020.RData')

for (i in files){
    load(paste0("./share/data/", i))
    data_df <- integrate_profile(data)
    name_out <- paste0("./share/data/clean_nexrad/", substr(i, 1, nchar(i)-5), "csv")
    write.csv(data_df, name_out, row.names=FALSE)
}