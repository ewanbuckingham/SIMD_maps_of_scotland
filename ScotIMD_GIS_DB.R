library(sf)        #for working with spatial data shapefiles
library(tidyverse) #for data manipulations and pipes
library(readxl)    #for ingesting the source .xlsx
library(ggplot2)   #for charts (tmap is a great alternative with faster rendering but less pretty output)
library(viridis)   #for colour palettes that work better for those with visual impairment
library(stringr)   #for string manipulation

#Access AlwaysData PostGIS database
#Secure connection to the production branch (credentials in config.yml)
dw <- config::get("always_data_production")
con <- dbConnect(
  drv = RPostgres::Postgres(),
  dbname=dw$dbname,
  host=dw$host,
  port= dw$port,
  user=dw$user,
  password=dw$password
)

#Select only the data relevant to users in the chosen city:
user_choice = "Glasgow City"
var =  paste0("select \"DZName\", \"LAName\", \"GAccBrdbnd\", \"geometry\" from \"datazone\" where \"LAName\" =\'", user_choice,"\';")         
datazone <- st_read(con, query = var, as_tibble = TRUE)

datazone$GAccBrdbnd <- as.numeric(gsub("\\%", "", datazone$GAccBrdbnd))
# Visualise the distribution of IMD deciles across Scotland
# -------------------------------------------------------------------------

# Chosen City -- Broadband Speeds
ggplot(datazone)+
  geom_sf(aes(fill = GAccBrdbnd), colour = NA) + 
  theme_void() +
  labs(title = "City of Glasgow - Percentage access High Speed Broadband", caption = paste0("Scot.gov SIMD data")) +
  scale_fill_viridis(name = "Percent", option = "E")