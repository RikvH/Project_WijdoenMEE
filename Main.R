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
source("CalculateAltitude.R")

## Load packages
packages <- c("osmar", "sp", "raster")
packageloader(packages)

## Load data
ned <- getData('SRTM', lon = 5, lat = 51)
nedcrop <- crop(ned, c(5.65, 5.7,51.965, 51.99))