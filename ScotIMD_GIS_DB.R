library(sf)        #for working with spatial data shapefiles
library(tidyverse) #for data manipulations and pipes
library(readxl)    #for ingesting the source .xlsx
library(ggplot2)   #for charts (tmap is a great alternative with faster rendering but less pretty output)
library(viridis)   #for colour palettes that work better for those with visual impairment
library(stringr)   #for string manipulation
library(DBI)

#Access AlwaysData PostGIS database
#Secure connection to the production branch (credentials in config.yml)

#Contains data for the first 18k records of the original datazone dataset (100MB limit on the free tier)
dw <- config::get("always_data_production")
con <- dbConnect(
  drv = RPostgres::Postgres(),
  dbname=dw$dbname,
  host=dw$host,
  port= dw$port,
  user=dw$user,
  password=dw$password
)
rm(dw)

#At the LAName level the first 18k rows contain Aberdeen City, Aberdeenshire and part of Angus
#Individual towns tend to be covered by multiple zones. Many of the towns are twinned e.g.
# 'Crathes and Torphins', 'Cromar and Kildrummy'. Others have multi-word names like
# 'Howe of Alford'. The SQL LIKE operator lets us pattern match based on the string
# this seems like the best way to resolve this issue for the moment. 

#Select only the data relevant datazones at city/county scale (slow to render):
user_choice = "Aberdeen City"
var =  paste0("select \"DZName\", \"LAName\", \"GAccBrdbnd\", \"geometry\" from \"datazone\" where \"LAName\" =\'", user_choice,"\';")         
datazone <- st_read(con, query = var, as_tibble = TRUE)

#Select only the data relevant datazones at town/village scale:
user_choice = "Peterhead"
var =  paste0("select \"DZName\", \"LAName\", \"GAccBrdbnd\", \"geometry\" from \"datazone\" where \"DZName\" like \'", user_choice,"%\';")         
datazone <- st_read(con, query = var, as_tibble = TRUE)

# Visualise the distribution of IMD deciles across Scotland
# -------------------------------------------------------------------------

# Chosen City -- Broadband Speeds
ggplot(datazone)+
  geom_sf(aes(fill = GAccBrdbnd), colour = NA) + 
  theme_void() +
  labs(title = paste0(datazone$LAName[1]," - Percentage access High Speed Broadband"), caption = paste0("Scot.gov SIMD data")) +
  scale_fill_viridis(name = "Percent", option = "E")
