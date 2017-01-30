library(osmar)
library(igraph)

src <- osmsource_api()
wag_bbox <- center_bbox(5.672035, 51.975332, 1500, 1500)
wag <- get_osm(wag_bbox, src)
wag

hways_wag <- subset(wag, way_ids=find(wag, way(tags(k == "highway"))))
hways <- find(hways_wag, way(tags(k == "name")))
hways <- find_down(wag, way(hways))
hways_wag <- subset(wag, ids = hways)
hways_wag

hway_start_node <- local({ 
  id <- find(wag, node(attrs(lon == start_lon & lat == start_lat)))[1]
  find_nearest_node(wag, id, way(tags(k == "highway")))})
hway_start <- subset(wag, node(hway_start_node))

hway_end_node <- local({
  id <- find(wag, node(attrs(lon == dest_lon & lat == dest_lat)))[1]
  find_nearest_node(wag, id, way(tags(k == "highway")))})
hway_end <- subset(wag, node(hway_end_node))

plot_nodes(wag, col = "gray", pch = "." )
plot_ways(hways_wag, add = T)
plot_nodes(hways_wag, add = T, col = "black", pch = ".", cex = 2)
plot_nodes(hway_start, add = T, col = "red", pch = ".", cex = 6)
plot_nodes(hway_end, add = T, col = "blue", pch = ".", cex = 6)




gr_wag <- as_igraph(hways_wag)
gr_wag
ifrom <- as.character(hway_start_node)
ito <- as.character(hway_end_node)

route <- get.shortest.paths(gr_wag, 
                            ifrom,
                            ito)[[1]]

for (i in route){
  route_nodes <- as.numeric(V(gr_wag)[i]$name)
}



route_ids <- find_up(hways_wag, node(route_nodes))
route_wag <- subset(hways_wag, ids = route_ids)
route_wag


plot_nodes(route_wag, add=T, col="green")
plot_ways(route_wag, add=T, col="green")


