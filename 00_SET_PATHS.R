# ================================================================
# Script Name: set_path.R
# Purpose: Creates the locals, globals and installs packages
# Input Dataset: NA
# Output Dataset: NA
# Author: Chitra Balasubramanian
# Last Updated: 2024-08-05
# ================================================================

# List of required packages
packages <- c(
  "dplyr", "data.table", "zoo", "foreign", "haven", "sf", "tidyverse", 
  "paletteer", "raster", "ggplot2", "exactextractr", "readxl", "colorspace", 
  "ncdf4", "foreach", "doParallel", "readr", "sp", "scales", "gridExtra", 
  "geojsonio", "lwgeom", "classInt", "RColorBrewer", "purrr", "parallel", 
  "terra", "openxlsx", "leaflet", "blackmarbler", "geodata", "lubridate", 
  "tmap", "osrm", "janitor", "readstata13", "ggnewscale", "survey", "hrbrthemes", 
  "countrycode", "wbstats", "rpart", "rpart.plot", "caret", "ipred", "rsample", 
  "rattle", "fastDummies", "car", "stargazer", "plm", "nlme", "nortest", "MASS", 
  "codebook", "expss", "Polychrome", "ggthemes", "ggh4x", "gt", "tidytext", 
  "cowplot", "ggpubr", "patchwork", "fuzzyjoin", "reticulate"
)

# Install and load packages
new_packs <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(new_packs)) install.packages(new_packs)
lapply(packages, require, character.only = TRUE)

# Load all packages
invisible(lapply(packages, library, character.only = TRUE))

library(ggplot2)
library(renv)

  ### RAW DATASETS
  raw_replication <- file.path(getwd(), "Data", "REPLICATION_RAW_DATA")
  
  # PM2.5
  mena_file_path_air_pol <- file.path(raw_replication,"PM2_5")
  
  #FLOOD
  mena_file_path_flood <- file.path(raw_replication,"FLOOD")
  
  #HEAT STRESS
  mena_file_path_heat <-  file.path(raw_replication,"HEAT_STRESS")
  
  #RWI
  mena_file_path_rwi <- file.path(raw_replication, "RWI")
  
  #GMD Database
  data_hh_survey <- file.path(file.path(raw_replication, "HH_SURVEYS","raw"))
  
  ### FINAL DATASET
  final_replication <- file.path(getwd(), "Data", "REPLICATION_FINAL_DATA")
  
  mena_file_path <- final_replication
  
  ### OUTPUT
  graphs <- file.path(getwd(), "Paper Tables and Figures", "REPLICATION_OUTPUT", "GRAPHS")
  tables <- file.path(getwd(), "Paper Tables and Figures", "REPLICATION_OUTPUT", "TABLES")
  maps   <- file.path(getwd(), "Paper Tables and Figures", "REPLICATION_OUTPUT", "MAPS")



