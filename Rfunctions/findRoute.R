###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

# A function to calculate the shortest route from A to B over the "higroads" and "cycleways" defined 
# by Open Street Map


findRoute <- function (start_lat, start_lon, dest_lat, dest_lon){
  
  # Try the function, if the route cannot be created because the points are too far apart or cannot be 
  # connected by the graph, throw an error message. 
  tryCatch({
    
    # Criteria which roads should be matched
    crit <- way(tags(k == "highway" | k == "cycleway"))
    
    # Subset the roads
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
    
    # Make an igraph object
    gr_loc <- as_igraph(roads_loc)
    
    # Setting the start and destination nodes for the graph
    istart <- as.character(road_start_node)
    idest <- as.character(road_dest_node)
    
    # Calculate the shortest path consisting of numeric nodes
    shortpath <- get.shortest.paths(gr_loc, istart, idest, mode="all")[[1]]
    for (i in shortpath){
      shortpath_nodes <- as.numeric(V(gr_loc)[i]$name)
    }
    
    # Find the nodes and ways needed for the shortest route
    route_ids <- find_up(roads_loc, node(shortpath_nodes))
    route <- subset(roads_loc, ids = route_ids)
    
    return (route)
  }, 
  # Error message if the function cannot be executed
  error = function(e){
    message("Your start and destination points are too far apart or cannot be connected via the graph. Please
  choose different start and/or destination points or choose a different extent")
  })
}



