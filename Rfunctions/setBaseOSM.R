###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

# Function to set the basemap from Open Street Map

# Maps the inserted width and height around the center coordinates

setBaseOSM <- function(center_lat, center_lon, width, height){
  src <- osmsource_api()
  wag_bbox <- center_bbox(center_lat, center_lon, width, height)
  wag <- get_osm(wag_bbox, src)
}
  

