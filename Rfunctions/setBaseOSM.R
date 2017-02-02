###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

# Function to set the basemap from Open Street Map

# Maps between the inserted lat and lon extremes as a vector

# Format extent: lon_min, lon_max, lat_min, lat_max

# Throws a message when more than 50000 nodes are tried to be loaded.


setBaseOSM <- function(extent){
  
  # Trycatch tries to execute the function and throws an error if the function can not be executed
  tryCatch({
    
    # Set the source of the openstreetmap data
    src <- osmsource_api()
    
    # Select the extent and retrieve the data
    bbox <- center_bbox(extent[2], extent[1], extent[3], extent[4])
    area <- get_osm(bbox, source=src)
    return (area)
    
  # Error handling of the Trycatch  
  }, error = function(e){
    message("You try to load more than 50000 nodes, please make the width and/or 
height smaller in the 'ext' call.")
  }
  )
} 
