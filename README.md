# Replication Package for Climate Risk and Poverty in Middle East and North Africa

## Overview
This repository contains the replication package for the paper "Climate Risk and Poverty in Middle East and North Africa" by Chitra Balasubramanian, Sandra Baquie, Alan Fuchs (025). 

### Paper Abstract
   The Middle East and North Africa (MENA) faces significant climate challenges, such as increasing temperatures, heightened flood risks, frequent droughts, and growing air pollution issues. These challenges are compounded by 30-60\% of poverty in different countries in the region. Indeed, people living in poverty are more exposed to poor air quality and natural disasters as they tend to disproportionately live in hazard-prone areas. They are also more vulnerable as they may have scarcer resources to cope with shocks. This paper combines remote sensing, geospatial data, and household surveys to provide high-resolution assessments of the exposure and vulnerability of the MENA population and poor people to four types of climate shocks. Of the almost 24 million extreme poor (below \$2.15) in the region that we have available data for, we estimate that the entire 24 million are exposed to at least one climate shock. The region hosts climate-poverty hot spots in Yemen and Morocco, where adaptation to climate change will be crucial to end poverty. The resulting high-resolution estimates of exposure and vulnerability can inform the targeting of climate adaptation measures.

## Repository Structure
```
.
├── DataWork/
│   ├── 00_Master
│   ├── 00_downloading_datasets/
│   ├── 01_creating_analysis_ready_datasets/
│   │   ├── 01_CREATE_GRID.R
│   │   ├── 02_EXTRACT_AIR_POL.R
│   │   ├── 02_EXTRACT_AIRPORTS.R
│   │   ├── 02_EXTRACT_CITY_CENTERS.R
│   │   ├── 02_EXTRACT_CONFLICT.R
│   │   ├── 02_EXTRACT_CROP_YIELD.R
│   │   ├── 02_EXTRACT_DROUGHT.R
│   │   ├── 02_EXTRACT_EDUC_FACILITIES.R
│   │   ├── 02_EXTRACT_FLOOD.R
│   │   ├── 02_EXTRACT_FLOOD_PARTI.R
│   │   ├── 02_EXTRACT_FOREST_LOSS.R
│   │   ├── 02_EXTRACT_HEALTH_FACILITIES.R
│   │   ├── 02_EXTRACT_HEAT_STRESS.R
│   │   ├── 02_EXTRACT_POP.R
│   │   ├── 02_EXTRACT_PORTS.R
│   │   ├── 02_EXTRACT_RWI.R
│   │   ├── 02a_CLEAN_GAS_FLARES.R
│   │   ├── 02b_EXTRACT_BLM_NTL.R
│   │   ├── 02c_AGGREGATE_NTL_GAS_FLARES.R
│   │   ├── 03a_MERGE_CITIES_PORTS_AIRPORTS.R
│   │   ├── 03b_COMPUTE_TT_HEALTH_FACILITIES.R
│   │   ├── 03c_COMPUTE_TT_EDUC_FACILITIES.R
│   │   ├── 03d_COMPUTE_TT_MARKETS.R
│   │   ├── 03e_MERGE_TT_GRID.R
│   │   ├── 03f_SCORECARD_DIMS.R
│   │   ├── 03g_MERGE_SCORECARD.R
│   │   └── 03h_MERGE_ALL_VARIABLES.R
│   ├── 02_analysis/
│   │   ├── 01_ESTIMATE_NUMBER_POOR_RWI.R
│   │   ├── 02_CREATE_EXPOSED_POOR_215_685_HAZARD.R
│   │   ├── 03_CREATE_VULNERABILITY_THRESHOLDS.R
│   │   ├── 04_CREATE_POOR_EXPOSED_VULNERABLE.R
│   │   └── 05_CALCULATE_TOT_EXTREME_POOR.R
│   └── 03_figures_tables/
│       ├── 01_GRAPH_HAZARDS.R
│       ├── 02_GRAPHS_EXPOSED_POPULATION.R
│       ├── 03_GRAPHS_EXPOSED_POOR_215.R
│       ├── 04_GRAPHS_VULNERABILITY_INDICATORS.R
│       ├── 05_GRAPH_PEOPLE_EXPOSED_ALLHAZARDS.R
│       ├── 06_GRAPH_HAZARD_MATRIX.R
│       ├── 07_GRAPH_POOR_EXPOSED_ALLHAZARDS.R
│       ├── 08_GRAPH_POOR_EXPOSED_EGYPT.R
│       ├── 09_GRAPH_EXPOSED_POOR_OVERLAPS.R
│       ├── 10_GRAPH_EXPOSED_POOR_VULNERABLE.R
│       ├── 11_GRAPH_DENSITY_PLOT.R
│       ├── 12_GRAPH_COMPOSITION_VULNERABILITY.R
│       └── 13_GRAPH_POOR_EXPOSED_VULNERABLE_MOR_YEM.R
└── Paper Tables and Figures/
    └── REPLICATION_OUTPUT/
        ├── GRAPHS/
        ├── MAPS/

```

## Software Requirements
- Programming Language(s): 
  - R 4.2.1
- Required Packages:
  - R: Use script 00_SET_PATHS.R

### Data Availability Statement

This project uses multiple datasets, each of which is governed by its own access and licensing requirements. Below is a statement for each dataset, including the recommended folder structure for local storage and a link to the respective source.

---
## (a) Climate Risks

### 1. Heat Stress Index (GFDRR, World Bank)
**Name**  
Heat Stress Index data

**Note** 
After downloading from the GFDRR/World Bank website, please place the data under `REPLICATION_RAW_DATA/HEAT_STRESS`.  Source: GFDRR, World Bank.

**Access Policy**  
Publicly available, included in the repository.

**Data URL**  
[GFDRR / World Bank] (https://gfdrr.github.io/CCDR-tools/docs/hzd_hm-data.html#hzd-hm-hs)

---

### 2. Flood Data (Fathom)
**Name**  
Fluvial Flooding Data

**Note**  
The data was procured from GFDRR. After downloading data, place under `REPLICATION_RAW_DATA/FLOOD`. Source: Fathom.

**Access Policy**  
Restricted data and you need to submit a request form to access the data. Included in the repository.

**Data URL**  
[GFDRR](https://gfdrr.github.io/CCDR-tools/docs/hzd_hm-data.html#hzd-hm-fl)

---

### 3. Drought Data (FAO Agricultural Stress Index)
**Name**  
FAO Agricultural Stress Index data

**Note**  
After downloading from the FAO website, place under `REPLICATION_RAW_DATA/CROP_YIELD`. Source: FAO.

**Access Policy**  
Publicly available.  Raw files are included in the repository.

**Data URL**  
[GFDRR Website](https://gfdrr.github.io/CCDR-tools/docs/hzd_hm-data.html#hzd-hm-dr)

---

### 4. Air Pollution Data (Van Donkelaar et al. 2021)
**Name**  
Annual PM2.5 Concentration data

**Note**  
- Download from Van Donkelaar et al. (2021) repository or affiliated institutions, place under `REPLICATION_RAW_DATA/PM2_5`. Source: Van Donkelaar et al. (2021).

**Access Policy**  
Publicly available for research use. included in this repository.

**Data URL**  
[GFDRR](https://gfdrr.github.io/CCDR-tools/docs/hzd_env-data.html#hzd-env-ap)

---

## (b) Vulnerability Indicators

### 1. Nighttime Lights (NASA Black Marble)
**Name**  
Nighttime Lights data (2017-2021)

**Note**  
Download from NASA Black Marble, place under `REPLICATION_RAW_DATA/PM2_5`. We have scripts within the repo that pull from the NASA Black Marble data online. Source: NASA Black Marble.

**Access Policy**  
Publicly available (NASA open data). bundled in this repository.

**Data URL**  
[NASA Black Marble Portal](https://blackmarble.gsfc.nasa.gov/)

---

### 2. Aggregate Yield Achievement Ratio (FAO)
**Name**  
Yield Achievement Ratio data

**Note**  
Download from FAO, place under `REPLICATION_RAW_DATA/CROP_YIELD`. Source: FAO.

**Access Policy**  
- Publicly available. included in the repository

**Data URL**  
[FAO Statistics](https://data.apps.fao.org/map/catalog/srv/eng/catalog.search#/metadata/2e4efd5c-ed62-4fbd-a125-66a5b3be16af)

---

### 3. Markets (OpenStreetMap), 4. Educational Institutions (OpenStreetMap), 5. Health Facilities (OpenStreetMap)
**Name**  
Travel Time to Seaports, Airports, and Major City Centers

**Note**  
Derived from OpenStreetMap (OSM) layers, place results under `REPLICATION_RAW_DATA/OSM/raw/`. We download data from geofabrik.de. Source: OpenStreetMap.

**Access Policy**  
Open data license (ODbL).  

**Data URL**  
[OpenStreetMap](https://download.geofabrik.de/)

---

### 6. Conflict Events (ACLED)
**Name**  
Armed Conflict Location & Event Data

**Note**  
Download from ACLED, place under `REPLICATION_RAW_DATA/CONFLICT`. Source: Armed Conflict Location & Event Data Project (ACLED).

**Access Policy**  
- Publicly accessible with registration. Dataset not distributed via this repository due to ACLED’s redistribution limits.

**Data URL**  
[ACLED](https://acleddata.com/data/)

---

### 7. Forest Loss Cover (FAO)
**Name**  
Forest Loss Cover data (2000–2022)

**Note**  
- Download from FAO Forestry portal, place under `REPLICATION_RAW_DATA/FOREST_LOSS`. Source: Hansen et. al, 2013.

**Access Policy**  
Publicly available and included in the repository 

**Data URL**  
[Hansen et. al, 2013](https://developers.google.com/earth-engine/datasets/catalog/UMD_hansen_global_forest_change_2023_v1_11)

---
### 8. Global Financial Inclusion (Global Findex) Database 2021

**Name**
Global Financial Inclusion (Global Findex) Database 2021

**Note**
Source: World Bank. Date Accessed: March 2024 placed under `REPLICATION_RAW_DATA/HH_SURVEY/raw`. The dataset provides insights into global financial inclusion based on the 2021 Findex survey. The data was obtained from the World Bank Microdata Library and is publicly available for registered users.

**Access policy**
Public but does not allow republication. Publicly accessible through the World Bank's Microdata Library.

**Data URL**  
https://microdata.worldbank.org/index.php/catalog/4607

---
### 9. ASPIRE Database
**Name**
ASPIRE Database

**Note**
Source: World Bank placed under `REPLICATION_RAW_DATA/HH_SURVEY/raw`

**Access policy**
Published with the package

**License**
Creative Commons Attribution 4.0 International License (CC BY 4.0)

**License URL**
https://www.worldbank.org/en/about/legal/terms-of-use-for-datasets

**Data URL**
https://www.worldbank.org/en/data/datatopics/aspire/documentation

---
### 10. Global Subnational Poverty Atlas (GSAP)
**Name**
Global Subnational Poverty Atlas(GSAP)

**Note**
This data entry includes lined-up subnational poverty estimates (based on international poverty line(s)) for more than 168 economies at administrative unit level 1 in 2010, 2019, and 2021. Administrative unit level 1 refers to the highest subnational unit level (examples include ‘state’, ‘governorate’, ‘province’) from household surveys. The data is downloaded from the link and placed in `REPLICATION_RAW_DATA/GSAP`

**Access policy**
Published with the package and available publicly

**License**
Creative Commons Attribution 4.0

**Data URL**
https://datacatalog.worldbank.org/int/search/dataset/0042041/global_subnational_poverty_atlas_gsap

---
### 11. WorldPop
**Name**
WordPop

**Note**
Gridded Population data downloaded for 2020 for every MENA country and placed under `REPLICATION_RAW_DATA/POPULATION`

**Access policy**
Published with the package and available publicly

**License**
Creative Commons Attribution 4.0

**Data URL**
https://hub.worldpop.org/geodata/listing?id=74

---


## Instructions for Replication

### Data Preparation
0. Before starting, make sure to change paths in 00_SET_PATHS.R
1. All raw datasets are in REPLICATION_RAW in the Sharepoint folder:[https://worldbankgroup.sharepoint.com/sites/MENAPOVGeospatialFiles/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FMENAPOVGeospatialFiles%2FShared%20Documents%2FMENAPOV%20GEO%2FIntranet&p=true&ga=1](Link to raw data)
2. Run the scripts in 01_creating_analysis_ready_datasets/ to obtain the analysis datasets

### Analysis
Run the analysis scripts in 02_analysis/

### Expected Runtime 
One Day since there are two scripts ```02_EXTRACT_FLOOD.R + 02_EXTRACT_FLOOD_PARTI.R``` that are computationally heavy

## Results
The main results can be reproduced by running all the scripts in 03_figures_tables/

### Output Files
The output files are stored in Papers_and_Tables

## Additional Information
For any issues with replication, please contact cbalasubramania2@worldbank.org

## License


## Citation
```bibtex
@techreport{climate_risk_and_poverty,
  title={Climate Risk and Poverty in Middle East and North Africa},
  author={Balasubramanian,Chitra and Baquie, Sandra and Fuchs, Alan},
  year={2025},
  institution={World Bank Group},
  type={Policy Research Working Paper},
  address={Washington, D.C.},
}
```

## Acknowledgments
Analysis conducted as part of the Whole-of-Economy Trust Fund
