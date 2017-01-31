###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

# A function to calculate the shortest route from A to B over the "higroads" and "cycleways" defined 
# by Open Street Map


findRoute <- function (street_from, street_to){
  
  # Criteria which roads should be matched
  crit <- way(tags(k == "highway" | k == "cycleway"))
  
  # Subset the roads 
  # May be deleted when not plotted
  roads_loc <- subset(loc, way_ids=find(loc, crit))
  roads <- find(roads_loc, way(tags(k == "name")))
  roads <- find_down(loc, way(roads))
  roads_loc <- subset(loc, ids = roads)
  
  # Find start node
  road_start_node <- local({ 
    id <- find(loc, node(tags(v == street_from)))[1]
    find_nearest_node(loc, id, crit)})
  road_start <- subset(loc, node(road_start_node))
  
  # Find destination node
  road_dest_node <- local({
    id <- find(loc, node(tags(v == street_to)))[1]
    find_nearest_node(loc, id, crit)})
  road_dest <- subset(loc, node(road_dest_node))
  
  # Plotting
  plot_nodes(loc, col = "gray", pch = "." )
  plot_ways(roads_loc, add = T)
  plot_nodes(roads_loc, add = T, col = "black", pch = ".", cex = 2)
  plot_nodes(road_start, add = T, col = "red", pch = ".", cex = 6)
  plot_nodes(road_dest, add = T, col = "blue", pch = ".", cex = 6)
  
  # Making the graph
  gr_loc <- as_igraph(roads_loc)

  # Setting the start and destination nodes for the graph
  istart <- as.character(road_start_node)
  idest <- as.character(road_dest_node)
  
  # Create the shortest path
  shortpath <- get.shortest.paths(gr_loc, istart, idest, mode="all")[[1]]
  for (i in shortpath){
    shortpath_nodes <- as.numeric(V(gr_loc)[i]$name)
  }
  
  # Find the nodes and ways needed for the shortest route
  route_ids <- find_up(roads_loc, node(shortpath_nodes))
  route <- subset(roads_loc, ids = route_ids)
  
  # Plot it to to previous plots
  plot_nodes(route, add=T, col="green", pch = ".", cex = 4)
  plot_ways(route, add=T, col="green")
  
  return (route)
}



