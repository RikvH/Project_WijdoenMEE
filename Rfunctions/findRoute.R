###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

# A function to calculate the shortest route from A to B over the "higroads" and "cycleways" defined 
# by Open Street Map


findRoute <- function (start_lat, start_lon, dest_lat, dest_lon){
  
  # Criteria which roads should be matched
  crit <- way(tags(k == "highway" | k == "cycleway"))
  
  # Subset the roads 
  # May be deleted when not plotted
  roads_loc <- subset(loc, way_ids=find(loc, crit))
  roads <- find(roads_loc, way(tags(k == "name")))
  roads <- find_down(loc, way(roads))
  roads_loc <- subset(loc, ids = roads)


  # Find start node
  nodes <- loc$nodes$attrs
  node_num_start <- which.min((abs(nodes$lon - start_lon) + abs(nodes$lat - start_lat))/2)
  id_start <- nodes[node_num_start, 1]
  
  road_start_node <- local({find_nearest_node(loc, id_start, crit)})
  
  road_start <- subset(loc, node(road_start_node))

  
  # Find destination node
  node_num_dest <- which.min((abs(nodes$lon - dest_lon) + abs(nodes$lat - dest_lat))/2)
  id_dest <- nodes[node_num_dest, 1]
  
  road_dest_node <- local({find_nearest_node(loc, id_dest, crit)})
  
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



