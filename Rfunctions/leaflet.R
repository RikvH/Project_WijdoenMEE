###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 2 February 2017               ##
###################################

# Function that plots the route on the leaflet map

plot_leaflet <- function(route_points){
  
  # Create a matrix of the lon and lat data of the route points
  lon_lat <- route_points@coords[,1:2]

  # Define a vector for the colors of the route
  col = c()
  for (i in 2:length(class)){
    if (class[i] == "steep downhill"){
      col[i] <- "darkgreen"
    } else if (class[i] == "rather steep downhill"){
      col[i] <- "forestgreen"
    } else if (class[i] == "downhill"){
      col[i] <- "lightgreen"
    } else if (class[i] == "flat terrain"){
      col[i] <- "gray"
    } else if (class[i] == "uphill"){
      col[i] <- "yellow"
    } else if (class[i] == "rather steep uphill"){
      col[i] <- "orange"
    } else {
      col[i] <- "red"
    }
  }
  
  # Add the color vector to the lon_lat vector
  lon_lat <- cbind(lon_lat,class, col)
  
  # Define the leaflet map
  map <- leaflet()
  
  # Add openstreetmap as the baselayer
  map <- addTiles(map)
  
  # Loop through the rows of lon_lat and for each two consecutive rows
  # Create a temporary vector (vector_total) containing the lat and lon data of these two points
  for (i in 1:nrow(lon_lat)){
    lon1 <- as.numeric(lon_lat[i,1])
    lat1 <- as.numeric(lon_lat[i,2])
    vector1 <- cbind(lon1, lat1)
    if (i < nrow(lon_lat)){
      # Loop through the next row (i+1)
      row <- lon_lat[i+1,]
      for (j in 1:length(row)){

        if (j == 1){
          lon2 <- as.numeric(row[j])
        } else if (j == 2){
          lat2 <- as.numeric(row[j])
        } else {
          col <- as.character(row[j])
        }
      }
    vector2 <- cbind(lon2, lat2)
    }
    vector_total <- rbind(vector1, vector2)
    
    # Add a polyline to the map for each segment using the temporary vector
    map <- addPolylines(map, lng = vector_total[,1], lat = vector_total[,2], col = col, opacity = 0.8)
  }
  
  # Add a legend
  map <- addLegend(map, position = "bottomright",
                   colors = c("cyan", "blue", "------------------------", "darkgreen", "forestgreen", "lightgreen",
                              "gray", "yellow", "orange", "red"),
                   title = "Legend",
                   labels = c("start point", "destination", "------------------------", "steep downhill", "rather steep downhill", "downhill",
                              "flat terrain", "uphill", "rather steep uphill", "steep uphill"))
  
  # Add the destination marker and attach the plot of the altitude vs distance in the popup
  file <- "plot.svg"  
  content1 <- paste0("<img src =", file, ">")
  map <- addCircleMarkers(map, lng = as.numeric(lon_lat[nrow(lon_lat),1]), 
                    lat = as.numeric(lon_lat[nrow(lon_lat),2]), popup = content1, color = "blue", opacity = 1)
  
  # Add the start point marker and attach the route description in the popup
  file2 <- readChar("Output/details.txt", file.info("Output/details.txt")$size)
  content2 <- paste("End point: ","The toughness of this route is:", round(sum(tough), digits = 3))
  map <- addCircleMarkers(map, lng = as.numeric(lon_lat[1,1]), lat = as.numeric(lon_lat[1,2]),
                    popup = file2, color = "cyan", opacity = 1)

# Return the map  
map
}


