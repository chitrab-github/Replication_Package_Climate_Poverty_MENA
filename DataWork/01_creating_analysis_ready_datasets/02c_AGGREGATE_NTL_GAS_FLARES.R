# ================================================================
# Script Name: 02c_AGGREGATE_NTL_GAS_FLARES.R
# Purpose: Combine Gas Flares and NTL to create non-gas flares and gas flares data
# Input Dataset: "grid_10km.shp",gas_flare_locations.Rds,VNP46A4_annual_rasters
# Output Dataset: grid_ntl_onlygf_10km.Rds, grid_ntl_nogf_10km.Rds
# Author: Chitra Balasubramanian
# Last Updated: 2024-08-09
# ================================================================


# Aggregate Nighttime Lights with and without gas flares
# Using script written by Rob Marty : https://github.com/datapartnership/myanmar-economic-monitor/blob/main/notebooks/nighttime-lights/analysis-2023/03_aggregate.R



# Load Data ---------------------------------------------------------------
#Gas Flares
gf_df <- readRDS(file.path(final_replication,"gas_flare_locations.Rds"))
grid_sf <- st_read(file.path(final_replication,  "grid_10km.shp"))
grid_sf <- st_transform(grid_sf, 4326)





# Convert to sf -----------------------------------------------------------
coordinates(gf_df) <- ~ longitude + latitude
crs(gf_df) <- CRS("+init=epsg:4326")
gf_sf <- gf_df %>% st_as_sf() %>% st_buffer(dist = 5000)





# Function to process a single year
process_year <- function(year, grid_sf, gf_sf) {
  # Filter gas flares for the current year
  gf_sf_year <- dplyr::filter(gf_sf, year == !!year)
  
  # Create union of gas flare geometries
  gf_sf_year_union <- gf_sf_year %>%
    sf::st_union() %>%
    sf::st_make_valid() %>%
    sf::st_as_sf()
  
  # Ensure grid is valid
  grid_sf_valid <- grid_sf %>% sf::st_make_valid()
  
  # Create intersections and differences
  grid_gf_sf <- sf::st_intersection(grid_sf_valid, gf_sf_year_union) %>% sf::st_as_sf()
  grid_nogf_sf <- sf::st_difference(grid_sf_valid, gf_sf_year_union) %>% sf::st_as_sf()
  
  # Save results
  saveRDS(grid_gf_sf, sprintf("grid_gf_%d.Rds", year))
  saveRDS(grid_nogf_sf, sprintf("grid_nogf_%d.Rds", year))
  
  return(list(gf = grid_gf_sf, nogf = grid_nogf_sf))
}

# Process NTL data for a grid
process_ntl <- function(grid, raster_data, year) {
  var_name <- paste0("ntl_mean_", year)
  grid[[var_name]] <- exactextractr::exact_extract(
    raster_data[[paste0("VNP46A4_t", year)]], 
    grid, 
    fun = "mean"
  )
  return(grid)
}

# Main processing pipeline
main_process <- function(years = 2017:2021) {
  # Load raster data
  raster_files <- list.files(
    path = file.path(raw_replication, "NTL", "raw"), # change the path here
    pattern = "\\.tif$",
    full.names = TRUE
  )
  raster_list <- setNames(
    lapply(raster_files, raster),
    sapply(raster_files, function(x) tools::file_path_sans_ext(basename(x)))
  )
  
  # Process each year
  grids <- list()
  for (year in years) {
    grids[[year]] <- process_year(year, grid_sf, gf_sf)
  }
  
  # Process NTL for both types of grids
  grid_sf_gf <- grid_sf
  grid_sf_nogf <- grid_sf
  
  for (year in years) {
    grid_sf_gf <- process_ntl(grid_sf_gf, raster_list, year)
    grid_sf_nogf <- process_ntl(grid_sf_nogf, raster_list, year)
  }
  
  # Convert NAs to 0
  for (year in years) {
    var_name <- paste0("ntl_mean_", year)
    grid_sf_gf[[var_name]][is.na(grid_sf_gf[[var_name]])] <- 0
    grid_sf_nogf[[var_name]][is.na(grid_sf_nogf[[var_name]])] <- 0
  }
  
  # Calculate change in NTL
  grid_sf_gf <- grid_sf_gf %>% 
    mutate(change_in_ntl_2021_2017 = ntl_mean_2021 - ntl_mean_2017)
  
  grid_sf_nogf <- grid_sf_nogf %>% 
    mutate(change_in_ntl_2021_2017 = ntl_mean_2021 - ntl_mean_2017)
  
  return(list(
    with_gas_flares = grid_sf_gf,
    without_gas_flares = grid_sf_nogf
  ))
}

# Usage
results <- main_process()
grid_sf_gf <- results$with_gas_flares
grid_sf_nogf <- results$without_gas_flares




# 
# # Create grid-gas flares intersection by year -----------------------------
# 
# 
# # Run the following code from 2017 to 2021. 
# gf_sf_year <- dplyr::filter(gf_sf, year == 2021) # Change the the Year here each time you want to run the code for a different year
# 
# 
# # Union and repair geometries for the current year
# gf_sf_year_union <- sf::st_union(gf_sf_year) %>% st_make_valid() %>% st_as_sf()
# grid_sf_valid <- grid_sf %>% st_make_valid()
# 
# 
# # Intersection between the valid grid and the unioned geometries for the current year
# grid_gf_sf <- sf::st_intersection(grid_sf_valid, gf_sf_year_union) %>% st_as_sf()
# 
# 
# # Difference between the original grid and the unioned geometries for the current year
# grid_nogf_sf <- sf::st_difference(grid_sf_valid, gf_sf_year_union) %>% st_as_sf()
# 
# 
# #saving the df
# saveRDS(grid_gf_sf,sprintf("M:/MENA/GEO/Nighttime_Lights/final/grid_gf_%d.Rds", 2021)) #Change year
# saveRDS(grid_nogf_sf,sprintf("M:/MENA/GEO/Nighttime_Lights/final/grid_nogf_%d.Rds", 2021)#Change year
# ) 
# 
# 
# 
# 
# # Extract NTL to this and original grid -----------------------------------
# 
# #Import NTL rasters
# raster_files <- list.files(path = "M:/MENA/GEO/Nighttime_Lights/raw/VNP46A4_annual_rasters" , pattern = "\\.tif$",full.names = TRUE)
# raster_list <- lapply(raster_files, raster)
# names(raster_list) <- sapply(raster_files, function(x) tools::file_path_sans_ext(basename(x)))
# 
# 
# 
# #Import gas flare and no gas flares grids
# rds_files <- list.files(path = "M:/MENA/GEO/Nighttime_Lights/final", pattern = "^grid_.*\\.Rds$", full.names = TRUE)
# grids <- lapply(rds_files, readRDS)
# names(grids) <- sapply(rds_files, function(x) tools::file_path_sans_ext(basename(x)))
# 
# 
# 
# 
# #With gas flares
# grids$grid_gf_2017$ntl_mean_2017 <- exactextractr::exact_extract(raster_list$VNP46A4_t2017, grids$grid_gf_2017, fun = "mean")
# grids$grid_gf_2018$ntl_mean_2018 <- exactextractr::exact_extract(raster_list$VNP46A4_t2018, grids$grid_gf_2018, fun = "mean")
# grids$grid_gf_2019$ntl_mean_2019 <- exactextractr::exact_extract(raster_list$VNP46A4_t2019, grids$grid_gf_2019, fun = "mean")
# grids$grid_gf_2020$ntl_mean_2020 <- exactextractr::exact_extract(raster_list$VNP46A4_t2020, grids$grid_gf_2020, fun = "mean")
# grids$grid_gf_2021$ntl_mean_2021 <- exactextractr::exact_extract(raster_list$VNP46A4_t2021, grids$grid_gf_2021, fun = "mean")
# 
# 
# 
# #without gas flares
# grids$grid_nogf_2017$ntl_mean_2017 <- exactextractr::exact_extract(raster_list$VNP46A4_t2017, grids$grid_nogf_2017, fun = "mean")
# grids$grid_nogf_2018$ntl_mean_2018 <- exactextractr::exact_extract(raster_list$VNP46A4_t2018, grids$grid_nogf_2018, fun = "mean")
# grids$grid_nogf_2019$ntl_mean_2019 <- exactextractr::exact_extract(raster_list$VNP46A4_t2019, grids$grid_nogf_2019, fun = "mean")
# grids$grid_nogf_2020$ntl_mean_2020 <- exactextractr::exact_extract(raster_list$VNP46A4_t2020, grids$grid_nogf_2020, fun = "mean")
# grids$grid_nogf_2021$ntl_mean_2021 <- exactextractr::exact_extract(raster_list$VNP46A4_t2021, grids$grid_nogf_2021, fun = "mean")
# 
# 
# 
# 
# 
# # Create complete grid for gas flares -------------------------------------
# 
# 
# # Define a function to convert and process data
# convert_and_process <- function(grid_year, year) {
#   grid_df <- as.data.frame(grids[[grid_year]])
#   grid_df <- grid_df %>%
#     st_drop_geometry() %>%
#     dplyr::select(grid_id,!!paste0("ntl_mean_", year))
# }
# 
# # Define the grid years
# grid_years <-
#   c("grid_gf_2017",
#     "grid_gf_2018",
#     "grid_gf_2019",
#     "grid_gf_2020",
#     "grid_gf_2021")
# 
# # Apply the function to each grid year
# for (grid_year in grid_years) {
#   year <- str_extract(grid_year, "\\d+") 
#   assign(grid_year, convert_and_process(grid_year, year))
# }
# 
# #Note to Sandra: How do we explain 0 ntl in gas flare dataframes?
# summary(grid_gf_2017$ntl_mean)
# 
# #Combine them
# grid_sf_gf <- grid_sf %>%
#   left_join(grid_gf_2017, by = c("grid_id")) %>%
#   left_join(grid_gf_2018, by = c("grid_id")) %>%
#   left_join(grid_gf_2019, by = c("grid_id")) %>%
#   left_join(grid_gf_2020, by = c("grid_id")) %>%
#   left_join(grid_gf_2021, by = c("grid_id"))
# 
# 
# 
# 
# 
# 
# 
# 
# # Combine the non_gas_flare grids -----------------------------------------
# 
# # Define the grid years
# grid_years_no_gf <- c("grid_nogf_2017", "grid_nogf_2018", "grid_nogf_2019", "grid_nogf_2020", "grid_nogf_2021")
# 
# # Apply the function to each grid year
# for (grid_year in grid_years_no_gf) {
#   year <- str_extract(grid_year, "\\d+")  # Extract year from grid_year
#   assign(grid_year, convert_and_process(grid_year, year))
# }
# 
# 
# #Combine them
# grid_sf_nogf <- grid_sf %>%
#   left_join(grid_nogf_2017, by = c("grid_id")) %>%
#   left_join(grid_nogf_2018, by = c("grid_id")) %>%
#   left_join(grid_nogf_2019, by = c("grid_id")) %>%
#   left_join(grid_nogf_2020, by = c("grid_id")) %>%
#   left_join(grid_nogf_2021, by = c("grid_id"))
# 
# summary(grid_sf_nogf$ntl_mean_2021)
# 
# 
# 
# 
# 
# 
# 
# # Convert NAs to 0  -------------------------------------------------------
# #only gas flares
# years <- 2017:2021 # Define the range of years
# variable_names <-paste0("ntl_mean_", years)  # Create the variable names
#  
# # Loop through each variable and recode NAs to 0
# for (var_name in variable_names) {
#   grid_sf_gf[[var_name]][is.na(grid_sf_gf[[var_name]])] <- 0
# }
# 
# 
# #without gas flares
# for (var_name in variable_names) {
#   grid_sf_nogf[[var_name]][is.na(grid_sf_nogf[[var_name]])] <- 0
# }
# 
# 
# 
# 
# 
# 
# 
# # Compute the change in NTL -----------------------------------------------
# #only gas flares
# 
# grid_sf_gf <- grid_sf_gf %>% mutate(change_in_ntl_2021_2017 = ntl_mean_2021 - ntl_mean_2017)
# 
# #without flares
# grid_sf_nogf <- grid_sf_nogf %>% mutate(change_in_ntl_2021_2017 = ntl_mean_2021 - ntl_mean_2017)
# 
# 
# 
# 
# # Export ------------------------------------------------------------------
# 
# #only gas flares
# saveRDS(grid_sf_gf,file.path(final_replication,"grid_ntl_onlygf_10km.Rds"))
# 
# #without gas flares
# saveRDS(grid_sf_nogf,file.path(final_replication,"grid_ntl_nogf_10km.Rds"))
# 
# 
