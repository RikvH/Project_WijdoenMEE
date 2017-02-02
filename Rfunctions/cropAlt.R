###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 31 January 2017               ##
###################################

# Function to crop the height map to a smaller extent
# Extent based on the extent of the graph

cropAlt <- function (ext){
  
  # Define the extent
  extent <- c(ext[1]-0.015, ext[1]+0.015, ext[2]-0.03, ext[2]+0.03)
  
  # Download the West and East of the Netherlands and merge them together
  
  tryCatch({nedW <- getData('SRTM', lon = 4, lat = 51, path = "Data")}, error = function(e){message("Error in writing to file, this can be ignored, download will continue")}, finally =  { nedW <- raster("Data/srtm_37_02.tif")})
  tryCatch({nedE <- getData('SRTM', lon = 5, lat = 51, path = "Data")}, error = function(e){message("Error in writing to file, this can be ignored, download will continue")}, finally =  { nedE <- raster("Data/srtm_38_02.tif")})
  ned <- merge(nedW, nedE)
  
  # Crop the Netherlands to the extent
  nedcrop <- crop(ned, extent(extent[3], extent[4], extent[1], extent[2]))
  return (nedcrop)
}