#####################################
### How tough is a cycling route? ###
###                               ###
###       Team Wij doen MEE       ###
### Rik van Heumen & Dillen Bruil ###
###                               ###
###    GeoScripting - GRS30806    ###
###        Period 3 - 2017        ###
#####################################

#rm(list=ls())

### IMPORTANT NOTE! PLEASE RUN SECTION 2 BEFORE RUNNING SECTIONS 3 AND 4.
### SECTION 2 REQUIRES AN INPUT, IN CASE OF NO RESPONSE, THE SCRIPT WILL NOT CONTINUE TO RUN

### Section 1: Set up -------------------------------------------------------------------------------------------------

## Load functions
source("Rfunctions/packageloader.R")
source("Rfunctions/cropAlt.R")
source("Rfunctions/setBaseOSM.R")
source("Rfunctions/create_osmar.R")
source("Rfunctions/findRoute.R")
source("Rfunctions/routeDetails.R")
source("Rfunctions/CalculateAltitude.R")
source("Rfunctions/nodeDiff.R")
source("Rfunctions/toughness.R")

## Load packages
packages <- c("osmar", "rgdal", "raster", "igraph")
packageloader(packages)

## Load data
# Center coordinates and width and height of the bounding box:
ext <- c(50.861065, 5.833611, 100, 100)

# Create height map
nedCrop <- cropAlt(ext)





### Section 2: Osmar object -------------------------------------------------------------------------------------------

# Create an osmar object
loc <- create_osmar(ext)





### Section 3: Route delivery -----------------------------------------------------------------------------------------

# Find shortest route
route <- findRoute(50.862062, 5.833501, 50.865743, 5.832180)

# Create dataframe with the route details
route_details <- routeDetails(route)

# Make a spatial point data frame from the route 
route_points <- as_sp(route, "points")

# Extract altitude from the nodes
alt <- altitude(route_points)
  
# Calculate the total difference
vdist <- nodeDiff(alt)
sum(vdist)





### Section 4: Output -------------------------------------------------------------------------------------------------

# Calculate the toughness
tough <- toughness(vdist, route_details$dist)
tough

plot(nedCrop)
plot(route_points, add=T)

