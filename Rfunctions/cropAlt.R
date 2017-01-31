###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 31 January 2017               ##
###################################

# Function to crop the height map to a smaller extent
# Extent based on the extent of the graph

cropAlt <- function (ext){
  extent <- c(ext[1]-0.015, ext[1]+0.015, ext[2]-0.03, ext[2]+0.03)
  ned <- getData('SRTM', lon = 5, lat = 51, path = "Data")
  nedcrop <- crop(ned, extent(extent[3], extent[4], extent[1], extent[2]))
  return (nedcrop)
}