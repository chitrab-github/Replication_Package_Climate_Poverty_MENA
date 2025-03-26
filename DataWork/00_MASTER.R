# ================================================================
# Script Name: 00_MASTER.R
# Purpose: Master script to run all other scripts in a specific order
# Input Dataset: NA
# Output Dataset: NA
# Author: Chitra Balasubramanian
# Last Updated: 2024-08-05
# ================================================================



# Define the path to the directory containing the scripts
script_path <- "C:/Users/wb569257/OneDrive - WBG/Documents/GitHub/Replication_package_Climate_Poverty_MENA"

source(file.path(script_path,"00_SET_PATHS.R"))

#After running the "00_SET_PATHS.R" script to set the locals
# Source each script in the specified order
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "01_CREATE_GRID.R"))


## HAZARDS
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_AIR_POL.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_DROUGHT.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_FLOOD.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_HEAT_STRESS.R"))


#SOCIO-ECONOMIC CHARACTERISTICS
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_POP.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_RWI.R"))


## VULNERABILITY DIMENSIONS
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_AIRPORTS.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_PORTS.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_CITY_CENTERS.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_CONFLICT.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_CROP_YIELD.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_EDUC_FACILITIES.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_HEALTH_FACILITIES.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02_EXTRACT_FOREST_LOSS.R"))

#Create indicator for non-oil and oil economic activity
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02a_CLEAN_GAS_FLARES.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02b_EXTRACT_BLM_NTL.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "02c_AGGREGATE_NTL_GAS_FLARES.R"))

#Creating travel time estimates
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "03a_MERGE_CITIES_PORTS_AIRPORTS.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "03b_COMPUTE_TT_HEALTH_FACILITIES.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "03c_COMPUTE_TT_EDUC_FACILITIES.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "03d_COMPUTE_TT_MARKETS.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "03e_MERGE_TT_GRID.R"))


#Creating scorecard dimensions
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "03f_SCORECARD_DIMS.R"))
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "03g_MERGE_SCORECARD.R"))

#Merging all variables
source(file.path(script_path,"DataWork","01_creating_analysis_ready_datasets", "03h_MERGE_ALL_VARIABLES.R"))


################# ANALYSIS ############################

# Creating poverty estimates
source(file.path(script_path,"DataWork","02_analysis", "01_ESTIMATE_NUMBER_POOR_RWI.R"))

#Create estimates of population exposed to different hazards
source(file.path(script_path,"DataWork","02_analysis", "02_CREATE_EXPOSED_POOR_215_685_HAZARD.R"))

#Create vulnerability thresholds
source(file.path(script_path,"DataWork","02_analysis", "03_CREATE_VULNERABILITY_THRESHOLDS.R"))

# Create Population Exposed and Vulnerable
source(file.path(script_path,"DataWork","02_analysis", "04_CREATE_POOR_EXPOSED_VULNERABLE.R"))

# Calculate the total number of exposed poor
source(file.path(script_path,"DataWork","02_analysis", "05_CALCULATE_TOT_EXTREME_POOR.R"))


################# FIGURES ############################
source(file.path(script_path, "DataWork", "03_figures_tables", "01_GRAPH_HAZARDS.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "02_GRAPHS_EXPOSED_POPULATION.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "03_GRAPHS_EXPOSED_POOR_215.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "04_GRAPHS_VULNERABILITY_INDICATORS.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "05_GRAPH_PEOPLE_EXPOSED_ALLHAZARDS.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "06_GRAPH_HAZARD_MATRIX.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "07_GRAPH_POOR_EXPOSED_ALLHAZARDS.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "08_GRAPH_POOR_EXPOSED_EGYPT.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "09_GRAPH_EXPOSED_POOR_OVERLAPS.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "10_GRAPH_EXPOSED_POOR_VULNERABLE.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "11_GRAPH_DENSITY_PLOT.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "12_GRAPH_COMPOSITION_VULNERABILITY.R"))
source(file.path(script_path, "DataWork", "03_figures_tables", "13_GRAPH_POOR_EXPOSED_VULNERABLE_MOR_YEM.R"))



message("All scripts executed successfully.")
