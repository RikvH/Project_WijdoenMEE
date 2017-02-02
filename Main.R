#####################################
### How tough is a cycling route? ###
###                               ###
###       Team Wij doen MEE       ###
### Rik van Heumen & Dillen Bruil ###
###                               ###
###    GeoScripting - GRS30806    ###
###        Period 3 - 2017        ###
#####################################


### IMPORTANT NOTE! PLEASE RUN SECTION 2 BEFORE RUNNING SECTIONS 3 AND 4.
### SECTION 2 MIGHT REQUIRE AN INPUT, IN CASE OF NO RESPONSE, THE SCRIPT MIGHT NOT CONTINUE TO RUN

### The osmar method we use can only handle small extents, to fix this it is possible to use planet.osm
### but this takes too much time in a project of this time span.

### Section 1: Set up -------------------------------------------------------------------------------------------------

## Route path
# Please select two points that are relatively close to eachother
# Lat/lon of the startpoint of your route as a vector
start <- c(50.862062, 5.833501)
# Lat/lon of the destination point of your route as a vector
destination <- c(50.865743, 5.832180)


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
source("Rfunctions/writeDetails.R")
source("Rfunctions/leaflet.R")


## Load packages
packages <- c("osmar", "rgdal", "raster", "igraph", "leaflet",
              "htmlwidgets", "rmarkdown")
packageloader(packages)

## Create needed directories
drc <- c("Data", "Output")
for (i in drc){
  if (!file.exists(i)){
    dir.create(i)
  }
} 

## Load data
# Center coordinates and width and height of the bounding box:
# Center coordinates are extracted from the start and destination point
ext <- c((start[1]+destination[1])/2, (start[2]+destination[2])/2, 1500, 1500)

# Download and create height map
ahn <- cropAlt(ext)





### Section 2: Osmar object -------------------------------------------------------------------------------------------

# Create an osmar object
loc <- create_osmar(ext)





### Section 3: Route delivery -----------------------------------------------------------------------------------------

# Find shortest route
route <- findRoute(start[1],start[2], destination[1], destination[2])

# Create dataframe with the route details
route_details <- routeDetails(route)

# Make a spatial point data frame from the route 
route_points <- as_sp(route, "points")

# Extract altitude from the nodes
alt <- altitude(route_points)
route_details$alt <- alt
  
# Calculate the altitude difference between nodes and the total height difference
vdist <- nodeDiff(alt)

# Calculate the toughness
tough <- toughness(vdist, route_details$dist)

# Define classes
class <- classes(tough)




### Section 4: Output -------------------------------------------------------------------------------------------------
# Make output file with route details
writeDetails()

# Plot altitude to svg file
svg(filename = "plot.svg",
    width = 5,
    height = 4)
plot(route_details$cdist, route_details$alt, type = "l", main = "Altitude vs the distance", 
     xlab = "distance (m)", ylab = "altitude (m)")
grid(col = "gray")
dev.off()
file.copy(from = "plot.svg", to = "Output/plot.svg")
file.remove("plot.svg")

# Plot the route and add the route details and plot to the markers (you can click them)
leafletmap <- plot_leaflet(route_points)
saveWidget(leafletmap, file = "route.html")
file.copy(from = "route.html", to = "Output/route.html")
file.remove("route.html")

# Automatically open the html file in a browser
browseURL(file.path("Output/route.html"))
