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
source("Rfunctions/define_classes.R")
source("Rfunctions/leaflet.R")

## Load packages
packages <- c("osmar", "rgdal", "raster", "igraph", "leaflet")
packageloader(packages)

## Load data
# Center coordinates and width and height of the bounding box:
ext <- c(50.861065, 5.833611, 1500, 1500)

# Download and create height map
#ahn <- download_ahn(ext)
ahn <- cropAlt(ext)





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
route_details$alt <- alt
  
# Calculate the altitude difference between nodes and the total height difference
vdist <- nodeDiff(alt)
sum(vdist)





### Section 4: Output -------------------------------------------------------------------------------------------------

# Plot altitude
plot(route_details$cdist, route_details$alt, type = "line", main = "Altitude vs the distance", 
     xlab = "distance (m)", ylab = "altitude (m)")
grid(col = "gray")


# Calculate the toughness
tough <- toughness(vdist, route_details$dist)
tough

# Define classes
class <- classes(tough)
class
##tough_class <- cbind(tough, class)


# Plot the route
leafletmap <- plot_leaflet(route_points)
leafletmap
