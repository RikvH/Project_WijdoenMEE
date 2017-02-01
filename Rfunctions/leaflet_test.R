
plot_leaflet <- function(route_points){
lon <- route_points@coords[,1]
lat <- route_points@coords[,2]
library(leaflet)
map <- leaflet()
map <- addTiles(map)
map <- addPolylines(map, lng = lon, lat = lat)
map
}

