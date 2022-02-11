# Versatile map of Scotland showing SIMD data

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
    
### Scottish Index of Multiple Deprivations - Full List of Available Fields
 
 |                                | Indicator label | Indicator type     | Description                                                                                                                               |
|--------------------------------|-----------------|--------------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| Geography                      | DataZone        | Code               | 2011 data zone                                                                                                                            |
|                                | LAName          | Name               | Council area name                                                                                                                         |
| Population                     | SAPE2017        | Count              | 2017 NRS small area population estimates                                                                                                  |
|                                | WAPE2017        | Count              | 2017 NRS small area population estimates and state pension age                                                                            |
| Overall SIMD                   | Rankv2          | Rank               | Rank                                                                                                                                      |
|                                | Quintilev2      | Quantile           | Quintile                                                                                                                                  |
|                                | Decilev2        | Quantile           | Decile                                                                                                                                    |
|                                | Vigintilv2      | Quantile           | Vigintile                                                                                                                                 |
|                                | Percentv2       | Quantile           | Percentile                                                                                                                                |
| Income                         | IncRate         | Percentage         | Percentage of people who are income deprived                                                                                              |
|                                | IncNumDep       | Count              | Number of people who are income deprived                                                                                                  |
|                                | IncRankv2       | Rank               | Income domain rank                                                                                                                        |
| Employment                     | EmpRate         | Percentage         | Percentage of working age people who are employment deprived                                                                              |
|                                | EmpNumDep       | Count              | Number of working age people who are employment deprived                                                                                  |
|                                | EmpRank         | Rank               | Employment domain rank                                                                                                                    |
| Health                         | HlthCIFSR       | Standardised ratio | Comparative illness factor                                                                                                                |
|                                | HlthAlcSR       | Standardised ratio | Hospital stays related to alcohol use                                                                                                     |
|                                | HlthDrugSR      | Standardised ratio | Hospital stays related to drug use                                                                                                        |
|                                | HlthSMR         | Standardised ratio | Mortality                                                                                                                                 |
|                                | HlthDprsPc      | Percentage         | Proportion of population being prescribed drugs for anxiety, depression or psychosis                                                      |
|                                | HlthLBWTPc      | Percentage         | Proportion of live singleton births of low birth weight                                                                                   |
|                                | HlthEmerSR      | Standardised ratio | Emergency stays in hospital                                                                                                               |
|                                | HlthRank        | Rank               | Health domain rank                                                                                                                        |
| Education, Skills and Training | EduAttend       | Percentage         | School pupil attendance                                                                                                                   |
|                                | EduAttain       | Score              | Attainment of school leavers                                                                                                              |
|                                | EduNoQuals      | Standardised ratio | Working age people with no qualifications                                                                                                 |
|                                | EduNotPart      | Percentage         | Proportion of people aged 16-19 not participating in education, employment or training                                                    |
|                                | EduUniver       | Percentage         | 17-21 year olds entering university as a proportion of the 17-21 population                                                               |
|                                | EduRank         | Rank               | Education domain rank                                                                                                                     |
| Geographic Access to Services  | GAccPetrol      | Time (minutes)     | Average drive time to a petrol station in minutes                                                                                         |
|                                | GAccDTGP        | Time (minutes)     | Average drive time to a GP surgery in minutes                                                                                             |
|                                | GAccDTPost      | Time (minutes)     | Average drive time to a post office in minutes                                                                                            |
|                                | GAccDTPsch      | Time (minutes)     | Average drive time to a primary school in minutes                                                                                         |
|                                | GAccDTSsch      | Time (minutes)     | Average drive time to a secondary school in minutes                                                                                       |
|                                | GAccDTRet       | Time (minutes)     | Average drive time to a retail centre in minutes                                                                                          |
|                                | GAccPTGP        | Time (minutes)     | Public transport travel time to a GP surgery in minutes                                                                                   |
|                                | GAccPTPost      | Time (minutes)     | Public transport travel time to a post office in minutes                                                                                  |
|                                | GAccPTRet       | Time (minutes)     | Public transport travel time to a retail centre in minutes                                                                                |
|                                | GAccBrdbnd      | Percentage         | Percentage of premises without access to superfast broadband (at least 30Mb/s download speed)                                             |
|                                | GAccRank        | Rank               | Access domain rank                                                                                                                        |
| Crime                          | CrimeCount      | Count              | Number of recorded crimes of violence, sexual offences, domestic housebreaking, vandalism, drugs offences, and common assault             |
|                                | CrimeRate       | Rate               | Recorded crimes of violence, sexual offences, domestic housebreaking, vandalism, drugs offences, and common assault per 10,000 population |
|                                | CrimeRank       | Rank               | Crime domain rank                                                                                                                         |
| Housing                        | HouseNumOC      | Count              | Number of people in households that are overcrowded                                                                                       |
|                                | HouseNumNC      | Count              | Number of people in households without central heating                                                                                    |
|                                | HouseOCrat      | Percentage         | Percentage of people in households that are overcrowded                                                                                   |
|                                | HouseNCrat      | Percentage         | Percentage of people in households without central heating                                                                                |
|                                | HouseRank       | Rank               | Housing domain rank                                                                                                                       |
