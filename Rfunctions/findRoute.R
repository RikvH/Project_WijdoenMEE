###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 27 January 2017               ##
###################################


# library(osmar)
# library(igraph)

# A function to calculate the shortest route from A to B over the "higroads" and "cycleways" defined 
# by Open Street Map


findRoute <- function (start_lat, start_lon, dest_lat, dest_lon){
  
  # Criteria which roads should be matched
  crit <- way(tags(k == "highway" | k == "cycleway"))
  
  # Subset the roads 
  # May be deleted when not plotted
  roads_wag <- subset(wag, way_ids=find(wag, crit))
  roads <- find(roads_wag, way(tags(k == "name")))
  roads <- find_down(wag, way(roads))
  roads_wag <- subset(wag, ids = roads)
  
  # Find start node
  road_start_node <- local({ 
    id <- find(wag, node(attrs(lon > start_lon  & lat > start_lat )))[1]
    find_nearest_node(wag, id, crit)})
  road_start <- subset(wag, node(road_start_node))
  
  # Find destination node
  road_dest_node <- local({
    id <- find(wag, node(attrs(lon > dest_lon & lat > dest_lat )))[1]
    find_nearest_node(wag, id, crit)})
  road_dest <- subset(wag, node(road_dest_node))
  
  # Plotting
  plot_nodes(wag, col = "gray", pch = "." )
  plot_ways(roads_wag, add = T)
  plot_nodes(roads_wag, add = T, col = "black", pch = ".", cex = 2)
  plot_nodes(road_start, add = T, col = "red", pch = ".", cex = 6)
  plot_nodes(road_dest, add = T, col = "blue", pch = ".", cex = 6)
  
  # Making the graph
  gr_wag <- as_igraph(roads_wag)
  
  # Setting the start and destination nodes for the graph
  istart <- as.character(road_start_node)
  idest <- as.character(road_dest_node)
  
  # Create the shortest path
  route <- get.shortest.paths(gr_wag, istart, idest)[[1]]
  for (i in route){
    route_nodes <- as.numeric(V(gr_wag)[i]$name)
  }
  
  # Find the nodes and ways needed for the shortest route
  route_ids <- find_up(roads_wag, node(route_nodes))
  route_wag <- subset(roads_wag, ids = route_ids)
  
  # Plot it to to previous plots
  plot_nodes(route_wag, add=T, col="green", pch = ".", cex = 4)
  plot_ways(route_wag, add=T, col="green")
  
  # Make a spatial point data frame from the route 
  route_points <- as_sp(route_wag, "points")
}



findRoute(51.9709465, 5.6689275, 51.978103, 5.6713907)

#this one will fail
#findRoute(51.9770748, 5.6751353, 51.9784534, 5.6683752)

