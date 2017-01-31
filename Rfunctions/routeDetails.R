###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 31 January 2017               ##
###################################

## Fucntion to create a data frame with route details

routeDetails <- function(route){
  
  # Extract the node id's which are in the correct order of the route
  # and extract the way id's which need to be ordered to the route
  node_ids <- route$nodes$attrs$id
  way_ids <- local({
    w <- match(node_ids, route$ways$refs$ref)
    route$ways$refs$id[w]
  })
  
  # Extract the names of the ways in the correct order
  way_names <- local({
    n <- subset(route$ways$tags, k == "name")
    n[match(way_ids, n$id), "v"]
  })
  
  # Extract the coordinates
  node_coords <- route$node$attrs[,c("lon", "lat")]
  
  # Compute distances and directions
  node_dirs <- local({
    n <- nrow(node_coords)
    from <- 1:(n-1)
    to <- 2:n
    
    cbind(dist=c(0, distHaversine(node_coords[from,], 
                                  node_coords[to,])),
          bear = c(0, bearing(node_coords[from,],
                              node_coords[to, ])))
  })
  
  # Function that defines the direction on a compass
  compass <- function(bearing) {
    dir <- function(x) {
      switch(as.character(x),
             "0" = "N",
             "1" = "NNE",
             "2" = "NE",
             "3" = "ENE",
             "4" = "E",
             "5" = "ESE",
             "6" = "SE",
             "7" = "SSE",
             "8" = "S",
             "9" = "SSW",
             "10" = "SW",
             "11" = "WSW",
             "12" = "W",
             "13" = "WNW",
             "14" = "NW",
             "15" = "NNW",
             "16" = "N"
      )
      } 
    sapply(round(bearing / 22.5), dir)
    }
  
  # Create data frame
  route_details <- data.frame(way_names, node_dirs)
  # Convert negative bearing to positive bearing 
  for (i in 1:length(route_details$bear)){if (route_details$bear[i] < 0){ route_details$bear[i] <- route_details$bear[i] +360 }}
  # Calculate and add cumulative distance to the data frame
  route_details$cdist <- cumsum(route_details$dist)
  # Calculate and add compass direction to the data frame
  route_details$dir <- compass(route_details$bear)
  # Return data frame with route details
  return(route_details)
  }


