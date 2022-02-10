library(sf)        #for working with spatial data shapefiles
library(tidyverse) #for datamanipulations and pipes
library(readxl)    #for ingesting the source .xlsx
library(ggplot2)   #for charts (tmap is a great alternative with faster rendering but less pretty output)
library(viridis)   #for colour palettes that work better for those with visual impairment
library(stringr)   #for string manipulation

#----------------------------------------
# *** This script creates a static .png render of Scotland to illustrate socio-economic trends. ***
# *** SIMD (Scottish Index of Multiple Deprivations) is used but it can be easily adapted for   ***
# *** any dataset where you have either postcodes or datazones. It can be used for the whole    ***
# *** country or subsetted for individual areas.                                                ***
# ***                                                                                           ***
# *** Other UK regions use different Datazone/LSOA formats and their IMD data also differs      ***
# *** slightly however this method works for them all with minimal adjustment.
#----------------------------------------
# 
#Datasets used to create these plots:
# 
#   * Scottish Index of Multiple Deprivation Shapefile from spatialdata.gov.scot
#     https://maps.gov.scot/ATOM/shapefiles/SG_SIMD_2020.zip
#     Downloaded 2022/01/05 
# 
#   * Postcode-LSOA lookup from gov.scot:
#     https://www.gov.scot/publications/scottish-index-of-multiple-deprivation-2020v2-postcode-look-up/
#     Downloaded 2022/01/05
#
#   * Total population estimates for each datazone from National Records of Scotland
#     https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/population/population-estimates/small-area-population-estimates-2011-data-zone-based/mid-2020
#     --Download: sape-20-all-tabs-and-figs.xlsx (it contains more context to understand the data than the .csv)
#     Downloaded 2022/01/07
# 
# Read-in and tidy the Shapefile, Population estimates and Postcode lookup data:
# ----------------------------------------------------------------------------------------
# Shapefile - includes a useful glossary of field names as an .xlsx file
datazone <- st_read("data/Shapefiles/SG_SIMD_2020.shp")

#Read-in total population estimate for each datazone from TabA (this may include NA values)
total_population <- readxl::read_excel("data/sape-20-all-tabs-and-figs.xlsx", sheet = "TabA", skip = 2)
# Filter out the datazone codes and select only the total_population column
total_population <- total_population %>% filter(stringr::str_detect(DataZone2011Code, '[a-zA-Z]{1}\\d{8}')) %>%
  select(DataZone2011Code, `Total population`) %>%
  rename(total_popn = `Total population`)
datazone <- left_join(datazone, total_population, by = c("DataZone" = "DataZone2011Code"))
rm(total_population)

#Read-in postcode data (on second tab of the .xlsx). We only need the postcode-datazone lookup. 
postcode_lookup <- readxl::read_xlsx("data/postcode_lookup_2020.xlsx", sheet = 2) %>%
select(1:2)

datazone <- left_join(datazone, postcode_lookup, by=c("DataZone" = "DZ"))

#postcode_lookup is now in datazone and no longer required as a seperate table.
rm(postcode_lookup)

#I'm primarily interested in Broadband connection speed, which isn't provided in a numeric format. 
# The "%" sign needs to be removed and the variable re-typed. The full list of measures available 
# in the SIMD is explained in its glossary. There's a lot in there.
datazone$GAccBrdbnd <- as.numeric(gsub("\\%", "", datazone$GAccBrdbnd))

# Visualise the distribution of IMD deciles across Scotland
# -------------------------------------------------------------------------

# Glasgow -- Broadband Speeds
plt <- datazone %>% filter(LAName == "Glasgow City")

plt <- ggplot(plt)+
  geom_sf(aes(fill = GAccBrdbnd), colour = NA) + 
  theme_void() +
  labs(title = "City of Glasgow - Percentage access High Speed Broadband", caption = paste0("Scot.gov SIMD data")) +
  scale_fill_viridis(name = "Percent", option = "E")

ggsave("plots/glasgow_broadband.png", plt)

# Scotland -- Broadband Speeds (can take time to render - c.30mins on a 2014 MacBook Air)
plt <- datazone

plt <- ggplot(plt)+
  geom_sf(aes(fill = GAccBrdbnd), colour = NA) +
  theme_void() +
  labs(title = "Scotland - Percentage access to High Speed Broadband", caption = paste0("Scot.gov SIMD data")) +
  scale_fill_viridis(name = "Percent", option = "E")

ggsave("plots/scotland_broadband.png", plt)
