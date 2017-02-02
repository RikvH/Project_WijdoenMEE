###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

## Function to extract the altitude along the route from a DEM
## It prints the min altitude and the max altitude and their difference
## And returns a plot of the altitude

altitude <- function(routepoints){
  
  # Transform the route points to the projection of the DEM
  projroute <- spTransform(routepoints, CRS(proj4string(ahn)))
  
  # Extract the DEM data for the points
  alt <- extract(ahn, projroute, along = TRUE)
  return (alt)
}

