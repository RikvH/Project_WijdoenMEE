###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

## Function to extract the altitue along the route from a DEM
## It prints the min altitude and the max altitude and their difference
## And returns a plot of the altitude

altitude <- function(routepoints){
  projroute <- spTransform(routepoints, CRS(proj4string(ahn)))
  alt <- extract(ahn, projroute, along = TRUE)
  return (alt)
}

