###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

# Function to set the basemap from Open Street Map

# Maps between the inserted lat and lon extremes as a vector

# Format extent: lon_min, lon_max, lat_min, lat_max

setBaseOSM <- function(extent){
  
  src <- osmsource_api()
  bbox <- center_bbox(extent[2], extent[1], extent[3], extent[4])
  area <- get_osm(bbox, source=src)
  return (area)
}
  
