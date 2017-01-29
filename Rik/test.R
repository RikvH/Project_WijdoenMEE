rm(list=ls())
library(osmar)

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
hw_poly <- as_sp(hw, "polygons")

plot_ways(hw, col = "gray")

hway_start_node <- local({
  id <- find(ua, node(tags(v == "4040")))[1]
  find_nearest_node(ua, id, way(tags(k == "highway")))
})
hway_start <- subset(ua, node(hway_start_node))

hway_end_node <- local({
  id <- find(ua, node(tags(v == "11205")))[1]
  find_nearest_node(ua, id, way(tags(k == "highway")))
})
hway_end <- subset(ua, node(hway_end_node))

#plot(ua, col = "gray")
plot_ways(hw, add = TRUE, col = "green")
plot_nodes(hw, add = TRUE, col = "black")
plot_nodes(hway_start, add = TRUE, col = "red")
plot_nodes(hway_end, add = TRUE, col = "blue")

library(igraph)
gr_hw <- as_igraph(hw)

summary(gr_hw)

from <- as.character(hway_start_node)
tot <- as.character(hway_end_node)

test2 <- all_simple_paths(gr_hw, V(gr_hw)$from, to = V(gr_hw)$tot)
test <- shortest.paths(gr_hw, v=V(gr_hw)[from == fromt])


route <- shortest.paths(gr_hw, v=V(gr_hw), to=V(gr_hw))
route[from, tot]
route_ids <- find_up(hw, node(routes_nodes))
route_test <- subset(hw, ids = route_ids)
route_test

plot_ways(hw)
plot_nodes(route_test, add = TRUE, col = "green")
plot_ways(route_test, add = TRUE, col = "green")
