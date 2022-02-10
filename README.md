# Map of Scotland showing SIMD data
## Scottish Index of Multiple Deprivations

<p align="center"><img src="https://user-images.githubusercontent.com/14912609/153426999-f5319d4c-a810-4081-9796-6445ca833f23.png" width="400"></p>

This script creates static .png renders of Scotland to illustrate
socio-economic trends. SIMD (Scottish Index of Multiple Deprivations) is used but it can be easily adapted for any dataset where you have either postcodes or datazones. It can be used for the whole country or subsetted for individual areas.

Other UK regions use different Datazone/LSOA formats and their IMD data also differs slightly however this method works for them all with minimal adjustment.

<p align="center"><img src="https://user-images.githubusercontent.com/14912609/153427004-9f112f22-cbf8-4c60-9d92-0703c21cebfa.png" width="400"></p>

The following datasets are combined to create these plots. Download links are provided. Download dates shown here are when the files in the `/data` folder were downloaded.

-   [Scottish Index of Multiple Deprivation
    Shapefile](https://maps.gov.scot/ATOM/shapefiles/SG_SIMD_2020.zip)
    from spatialdata.gov.scot\
    Downloaded 2022/01/05

-   [Postcode-LSOA
    lookup](https://www.gov.scot/publications/scottish-index-of-multiple-deprivation-2020v2-postcode-look-up/)
    from gov.scot\
    Downloaded 2022/01/05

-   [Total population
    estimates](https://www.nrscotland.gov.uk/statistics-and-data/statistics/statistics-by-theme/population/population-estimates/small-area-population-estimates-2011-data-zone-based/mid-2020)
    for each datazone from National Records of Scotland\
    Download: `sape-20-all-tabs-and-figs.xlsx` (better context than the .csv)\
    Downloaded 2022/01/07
