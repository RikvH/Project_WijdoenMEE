#rm(list=ls())
library(osmar)
library(igraph)

src <- osmsource_api()
ref <- c(5.672035, 51.975332, 1500, 1500)
wag_bbox <- center_bbox(ref[1], ref[2], ref[3], ref[4])
wag <- get_osm(wag_bbox, src)


#findRoute <- function (start_lat, start_lon, dest_lat, dest_lon){
  
  hways_wag <- subset(wag, way_ids=find(wag, way(tags(k == "highway"))))
  hways <- find(hways_wag, way(tags(k == "name")))
  hways <- find_down(wag, way(hways))
  hways_wag <- subset(wag, ids = hways)
  
  hway_start_node <- local({ 
    id <- find(wag, node(attrs(lon > start_lon  & lat > start_lat )))[1]
    find_nearest_node(wag, id, way(tags(k == "highway")))})
  hway_start <- subset(wag, node(hway_start_node))
  
  hway_dest_node <- local({
    id <- find(wag, node(attrs(lon > dest_lon & lat > dest_lat )))[1]
    find_nearest_node(wag, id, way(tags(k == "highway")))})
  hway_dest <- subset(wag, node(hway_dest_node))
  
  plot_nodes(wag, col = "gray", pch = "." )
  plot_ways(hways_wag, add = T)
  plot_nodes(hways_wag, add = T, col = "black", pch = ".", cex = 2)
  plot_nodes(hway_start, add = T, col = "red", pch = ".", cex = 6)
  plot_nodes(hway_dest, add = T, col = "blue", pch = ".", cex = 6)
  
  gr_wag <- as_igraph(hways_wag)
  
  ifrom <- as.character(hway_start_node)
  ito <- as.character(hway_dest_node)
  
  route <- get.shortest.paths(gr_wag, ifrom, ito)[[1]]
  
  for (i in route){
    route_nodes <- as.numeric(V(gr_wag)[i]$name)
  }
  
  route_ids <- find_up(hways_wag, node(route_nodes))
  route_wag <- subset(hways_wag, ids = route_ids)
  route_wag
  
  plot_nodes(route_wag, add=T, col="green")
  plot_ways(route_wag, add=T, col="green")
#}

#findRoute(51.9784473, 5.6629253, 51.9676534, 5.6683752)
start_lat <- 51.9709465
start_lon <- 5.6689275
dest_lat <- 51.978103
dest_lon <- 5.6713907
# 
# start_lat <- 51.9784473
# start_lon <- 5.6629253
# dest_lat <- 51.9676534
# dest_lon <- 5.6683752
