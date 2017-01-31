#####################################
### How tough is a cycling route? ###
###                               ###
###       Team Wij doen MEE       ###
### Rik van Heumen & Dillen Bruil ###
###                               ###
###    GeoScripting - GRS30806    ###
###        Period 3 - 2017        ###
#####################################


## Load functions
source("Rfunctions/packageloader.R")
source("Rfunctions/setBaseOSM.R")
source("Rfunctions/findRoute.R")
source("Rfunctions/CalculateAltitude.R")
source("Rfunctions/nodeDiff.R")

## Load packages
packages <- c("osmar", "rgdal", "raster", "igraph")
packageloader(packages)

## Load data
ned <- getData('SRTM', lon = 5, lat = 51)
nedcrop <- crop(ned, c(5.65, 5.7,51.965, 51.99))

## Run scripts

  # Set area
#wag <- setBaseOSM(5.672035, 51.975332, 1700, 1700)
  # Find shortest route


route <- findRoute(51.9700752,5.6681647, 51.965421, 5.659061)
# Make a spatial point data frame from the route 
route_points <- as_sp(route, "points")
#return (route_points)

#route_points <- findRoute(51.9709465, 5.6689275, 51.978103, 5.6713907)

  # Extract altitude from the nodes
alt <- altitude(route_points)
  
  # Calculate the total difference
diff <- nodeDiff(alt)
sum(diff)
