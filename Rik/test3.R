rm(list=ls())
setwd("M:/MSc1/geo_scripting/project")
library(osmar)
library(rgdal)
library(raster)

#load data
src <- osmsource_api()
bb <- center_bbox(5.672035, 51.975332, 1500, 1500)
ua <- get_osm(bb, source = src)
ua
plot(ua)

hw <- subset(ua, way_ids = find(ua, way(tags(k == "highway"))))
hw_ids <- find(ua, way(tags(k == "name")))
hw_ids <- find_down(ua, way(hw_ids))
hw <- subset(ua, ids = hw_ids)
hw
hw_poly <- as_sp(hw, "lines")
plot(hw_poly)
plot_ways(hw, col = "gray")

nodes <- subset(ua, node_ids = find(ua, node(tags(k == "highway"))))
node_ids <- find(ua, node(tags(k == "name")))
node_ids <- find_down(ua, node(node_ids))
nodes <- subset(ua, ids = node_ids)
nodes
plot(nodes)
nodes_poly <- as_sp(nodes, "points")

#load netherlands
ned <- getData('SRTM', lon = 5, lat = 51)
ned
plot(ned)
nedcrop <- crop(ned, c(5.65, 5.7,51.965, 51.99))
projways <- spTransform(hw_poly, CRS(proj4string(ned)))
projnodes <- spTransform(nodes_poly, CRS(proj4string(ned)))
plot(nedcrop, xlim = c(5.65,5.7), ylim = c(51.965,51.99))
plot(projways, add = TRUE)
plot(projnodes, add = TRUE)
#line <- drawLine()
plot(line, add = TRUE, col = "red")

#Analysis line
alt <- extract(nedcrop, line, along = TRUE)
plot(alt)
min <- min(alt[[1]])
max <- max(alt[[1]])
coord = coordinates(line)
coord

plot(alt[[1]], type = 'l', ylab = "Altitude (m)")

#Calculate distance
library(geosphere)
hor_dist <- as.numeric(distm(c(5.663041, 51.97205), c(5.691733,51.97594), fun = distHaversine))
vert_dist <- max - min

#Calcute toughness
test <- vert_dist/hor_dist
test

