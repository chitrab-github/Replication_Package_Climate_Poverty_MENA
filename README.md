# Climate Risk, Poverty and Vulnerability Analysis

## Overview
This repository aims to centrally maintain cleaning and analysis of the climate risk and vulnerability analysis that leverage geospatial data conducted by the Poverty and Equity Group in the MENA region. This project is nested within the Whole-of-Economy (WoE) work program.

## Repository Structure
The repository is divided into two main folders 'cleaning' and 'analysis'. There is separate R script '00_set_path.R' that installs the required packages and file paths relevant for the analysis.

Code files in the cleaning folder are detailed as follows. This folder includes scripts to extract the raw values from different layers and merge them to prepare a dataset for analysis at the 10km-by-10km grid level.

| Code Script                        | Purpose                                                                                      | Final Data Generated                                                                                        |
|------------------------------------|----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| `01_create_grid.R`                 | Creates the 10km-by-10km grid for MENA                                                       | `mena_file_path/Boundaries/final/grid_10km.Rds`                                                             |
| `02_extract_air_pol.R`             | Extracts air pollution data                                                                  | `mena_file_path/Hazards/PM2_5/final/grid_PM25_10km.Rds & mena_file_path/Hazards/PM2_5/final/grid_PM25_10km_v2.Rds` for 2015-2021 |
| `02_extract_droughts.R`            | Extracts drought data                                                                        | `mena_file_path/Hazards/ASI/final/grid_drought_10km.Rds`                                                    |
| `02_extract_flood.R`               | Extracts flood data                                                                          | `mena_file_path/Hazards/FLOOD/final/grid_flood_10km_resampled_allrps_120823.Rds`                            |
| `02_extract_heat_stress.R`         | Extracts heat stress data for analysis                                                       | `mena_file_path/Hazards/TEMP/final/grid_wbgt_10km_v2.Rds`                                                   |
| `02_extract_rwi.R`                 | Extracts RWI data                                                                            | `mena_file_path/RWI/final/grid_rwi_10km.Rds`                                                                |
| `02_extract_pop.R`                 | Extracts population data for analysis                                                        | `mena_file_path/Population/final/grid_pop_10km_v2.Rds`                                                      |
| `02_extract_airports.R`            | Extracts airport data by country                                                             | `mena_file_path/OpenStreetMap/raw/<country>/airports_<country>.shp`                                         |
| `02_extract_cities.R`              | Extracts city data by country                                                                | `mena_file_path/OpenStreetMap/raw/<country>/cities_<country>.shp`                                           |
| `02_extract_conflict.R`            | Extracts conflict data                                                                       | `mena_file_path/Conflict/final/grid_acled_10km.Rds`                                                         |
| `02_extract_crop_yields.R`         | Extracts crop yield data                                                                     | `mena_file_path/Agriculture/FAO_GAEZ_yield/final/grid_yield_achievement_ratio_10km.Rds`                     |
| `02_extract_educ_facilities.R`     | Extracts educational facilities data by country                                              | `mena_file_path/OpenStreetMap/final/mena_educ_facilities.Rds & mena_file_path/OpenStreetMap/raw/<country>/educ_facilities_<country>.shp` |
| `02_extract_forest_cover.R`        | Extracts forest cover data                                                                   | `mena_file_path/Forest_Loss/final/grid_forest_loss_10km.Rds`                                                |
| `02_extract_health_facilities.R`   | Extracts health facilities data by country                                                   | `mena_file_path/OpenStreetMap/final/mena_health_facilities.Rds & mena_file_path/OpenStreetMap/raw/<country>/health_facilities_<country>.shp` |
| `02_extract_ports.R`               | Extracts port data by country                                                                | `mena_file_path/OpenStreetMap/raw/<country>/ports_<country>.shp`                                            |
| `02a_clean_gas_flares_data.R`      | Cleans raw gas flare data                                                                    | `mena_file_path/final/gas_flare_locations.Rds`                                                              |
| `02b_extract_blm_ntl.R`            | Extracts black marble nighttime lights data                                                  | `mena_file_path/raw/VNP46A4_annual_rasters`                                                                 |
| `02c_aggregate_ntl_gas_flares.R`   | Produces datasets with and without gas flares nighttime lights data                          | `mena_file_path/final/grid_ntl_onlygf_10km.Rds & mena_file_path/final/grid_ntl_nogf_10km.Rds`               |
| `03a_merge_cities_ports_airports.R`| Merges travel time data for cities, ports, airports by country                                | `mena_file_path/OpenStreetMap/final/mena_markets.Rds`                                                       |
| `03b_compute_tt_health_facilities.R`| Computes and creates CSV for each country with travel time to health facilities at grid level | `osm_final/final/health/final_output_<COUNTRY_NAME>.csv`                                                   |
| `03c_compute_tt_educ_facilities.R` | Computes and creates CSV for each country with travel time to educational facilities at grid level | `osm_final/final/educ/final_output_<COUNTRY_NAME>.csv`                                                     |
| `03d_compute_tt_markets.R`         | Computes and creates CSV for each country with travel time to markets at grid level           | `osm_final/final/markets/final_output_<COUNTRY_NAME>.csv`                                                   |
| `03e_merge_tt_grid.R`              | Merges the three travel time datasets into one grid                                          | Grid with columns representing travel time by education, health, and markets                                |
| `03f_merge.R`                      | Merges hazard layers and RWI in preparation for the progress review                          | `mena_file_path/Allsources/grid_10km_all_final.Rds`                                                         |
| `03g_merge_vul_indicators`         | Merges all vulnerability indicators                                                          | `mena_file_path/Allsources/grid_10km_all_vul_indicators.Rds`                                                |


Once we prepare, the intermediate datasets for analysis, we conduct a set of analysis on them. The "analysis" folder contains the following scripts:

| Code Script                       | Purpose                                                                                    | Input Dataset                                                                                      | Output Dataset                                                                                   |
|-----------------------------------|--------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| `01_estimate_number_poor_RWI`     | Reweights the RWI to match the GSAP poverty rate at the lowest administrative grid level   | `mena_file_path, "Allsources", "grid_10km_all_final.Rds"`                                         | `mena_file_path, "RWI", "final", "grid_rwi_gsap_final_corrected.Rds"`                            |
| `02a_create_exposed_poor_215_hazard.R` | Estimates number of people and poor exposed by each hazard for the 2.15 poverty threshold | `mena_file_path, "RWI", "final", "grid_rwi_gsap_final_corrected.Rds"`, `mena_file_path, "Allsources", "grid_10km_all_final.Rds"` | `final, "grid_10km_poor_final_corrected.Rds"`, `final, "grid_10km_people_final_corrected.Rds"`  |
| `02b_create_exposed_poor_685_hazard.R` | Same as above for the 6.85 poverty threshold                                              | `mena_file_path, "RWI", "final", "grid_rwi_gsap_final_corrected.Rds"`, `mena_file_path, "Allsources", "grid_10km_all_final.Rds"` | `final, "grid_10km_poor_final_685.Rds"`, `final, "grid_10km_people_final_685.Rds"`              |
| `03a_graphs_hazards.R`            | Create hazard maps                                                                         | None                                                                                               | Maps stored in `vulnerability/output/Figures/maps/MENA`                                         |
| `03b_exposed_population.R`        | Create maps for exposed populations                                                        | None                                                                                               | Maps stored in `vulnerability/output/Figures/maps/MENA`                                         |
| `03c_graphs_exposed_poor_215.R`   | Create maps for exposed poor                                                               | None                                                                                               | Maps stored in `vulnerability/output/Figures/maps/MENA`                                         |
| `03d_graphs_check`                | Perform robustness checks [need to archive]                                                | None                                                                                               | None                                                                                             |
| `03e_maps_rwi_gsap`               | Create maps showing overlaying and reweighting visually                                    | None                                                                                               | Maps stored in `vulnerability/output/Figures/maps/MENA`                                         |
| `04a_graphs_vulnerability_indicators` | Creates maps for each vulnerability indicator and combined dimensions                    | None                                                                                               | Maps stored in `vulnerability/output/Figures/maps/MENA`                                         |
| `04b_create_vulnerability_thresholds` | Choose thresholds to examine impact on the most vulnerable                                | `mena_file_path, "Allsources", "grid_10km_all_vul_indicators.Rds"`                                 | `mena_file_path, "AllSources", "grid_vul_10km_final.Rds"`                                       |
| `05_create_maps_by_country.R`     | Create template to make maps for each country separately                                   | None                                                                                               | None                                                                                             |
| `06_create_tables_pop_exposed.R`  | Create tables for total exposed people/poor by hazard and country [archive]               | None                                                                                               | None                                                                                             |
| `07a_tables_peoples_exposed_bycountry_hazard` | Create tables for total exposed people by hazard and country [archive]                    | None                                                                                               | None                                                                                             |
| `07b_tables_poor_exposed_bycountry_hazard.R` | Create tables for total exposed poor by hazard and country [archive]                      | None                                                                                               | None                                                                                             |
| `08_scorecard_dimensions`         | Merge grid and household data to replicate Ruth et. al [archive]                          | None                                                                                               | None                                                                                             |
| `Check_diff_arcgis_osm.R`         | Test robustness of the travel time function between arcgis and osrm                       | None                                                                                               | None                                                                                             |
| `Overlay_gsap_hhdata.R`           | Merge household dataset with grid                                                         | None                                                                                               | None                                                                                             |
| `Poor_grid_id_check.R`            | Check proper computation of non-squared cells in the grid                                 | None                                                                                               | None                                                                                             |
| `Rwi_robustness_check`            | Check robustness of weights generated for RWI                                             | None                                                                                               | Maps stored in `vulnerability/output/Figures/graphs`                                            |
| `Wealth_share_maps`               | Generate maps for the wealth sharing report                                               | None                                                                                               | Uploaded to the wealth share Onedrive shared by Sandra                                          |

=======
This repository is divided into two folders: "cleaning" and "analysis". The cleaning folder extracts the different layers required for the analysis and prepares the data for analysis. The analysis folder uses this dataset to conduct a host of analysis
| Code Script                           | Purpose                                                                                   | Final Data Generated                                                                |
|---------------------------------------|-------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| `01_create_grid.R`                    | Creates the 10km-by-10km grid for MENA                                                    | `mena_file_path, "Boundaries", "final", "grid_10km.Rds"`                            |
| `02_extract_air_pol.R`                | Extracts air pollution data                                                               | `grid_PM25_10km.Rds & grid_PM25_10km_v2.Rds` for 2015-2021                          |
| `02_extract_droughts.R`               | Extracts drought data                                                                     | `grid_drought_10km.Rds`                                                             |
| `02_extract_flood.R`                  | Extracts flood data                                                                       | `grid_flood_10km_resampled_allrps_120823.Rds`                                       |
| `02_extract_heat_stress.R`            | Extracts heat stress data for analysis                                                    | `grid_wbgt_10km_v2.Rds`                                                             |
| `02_extract_rwi.R`                    | Extracts RWI data                                                                         | `grid_rwi_10km.Rds`                                                                 |
| `02_extract_pop.R`                    | Extracts population data for analysis                                                     | `grid_pop_10km_v2.Rds`                                                              |
| `02_extract_airports.R`               | Extracts airport data by country                                                          | Files stored by country as `.shp`                                                   |
| `02_extract_cities.R`                 | Extracts city data by country                                                             | Files stored by country as `.shp`                                                   |
| `02_extract_conflict.R`               | Extracts conflict data                                                                    | `grid_acled_10km.Rds`                                                               |
| `02_extract_crop_yields.R`            | Extracts crop yield data                                                                  | `grid_yield_achievement_ratio_10km.Rds`                                             |
| `02_extract_educ_facilities.R`        | Extracts educational facilities data by country                                           | `mena_educ_facilities.Rds & files stored by country as .shp`                        |
| `02_extract_forest_cover.R`           | Extracts forest cover data                                                                | `grid_forest_loss_10km.Rds`                                                         |
| `02_extract_health_facilities.R`      | Extracts health facilities data by country                                                | `mena_health_facilities.Rds & files stored by country as .shp`                      |
| `02_extract_ports.R`                  | Extracts port data by country                                                             | Files stored by country as `.shp`                                                   |
| `02a_clean_gas_flares_data.R`         | Cleans raw gas flare data                                                                 | `gas_flare_locations.Rds`                                                           |
| `02b_extract_blm_ntl.R`               | Extracts black marble nighttime lights data                                               | `VNP46A4_annual_rasters`                                                            |
| `02c_aggregate_ntl_gas_flares.R`      | Produces datasets with and without gas flares nighttime lights data                       | `grid_ntl_onlygf_10km.Rds` and `grid_ntl_nogf_10km.Rds`                             |
| `03a_merge_cities_ports_airports.R`   | Merges travel time data for cities, ports, airports by country                             | `mena_markets.Rds`                                                                  |
| `03b_compute_tt_health_facilities.R`  | Computes and creates CSV for each country with travel time to health facilities at grid level | CSVs by country name                                                              |
| `03c_compute_tt_educ_facilities.R`    | Computes and creates CSV for each country with travel time to educational facilities at grid level | CSVs by country name                                                              |
| `03d_compute_tt_markets.R`            | Computes and creates CSV for each country with travel time to markets at grid level         | CSVs by country name                                                              |
| `03e_merge_tt_grid.R`                 | Merges the three travel time datasets into one grid                                        | Grid with columns representing travel time by education, health, and markets        |
| `03f_merge.R`                         | Merges hazard layers and RWI in preparation for the progress review                        | `grid_10km_all_final.Rds`                                                           |
| `03g_merge_vul_indicators`            | Merges all vulnerability indicators                                                        | `grid_10km_all_vul_indicators.Rds`                                                  |




## Installation and Dependencies

### R
To run the R scripts, you'll need R and RStudio (optional, but recommended) installed on your computer. You will also need to install the pacman package which is used to manage and install other R packages. Open RStudio or R and run the following command:
```
# Install the pacman package
install.packages("pacman")

```
After installing pacman, you can use it to install other required R packages. You can use the `_main_script.R` to install the other packages required for code in this repository.

```

## License

The <span style="color:#3EACAD">template</span> is licensed under the [**World Bank Master Community License Agreement**](LICENSE)

