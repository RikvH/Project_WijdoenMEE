
plot_leaflet <- function(route_points){
  
  lon_lat <- route_points@coords[,1:2]

  #Color
  col = c()
  for (i in 2:length(class)){
    if (class[i] == "steep downhill"){
      col[i] <- "darkgreen"
    } else if (class[i] == "rather steep downhill"){
      col[i] <- "green"
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
  lon_lat <- cbind(lon_lat,class, col)
  
  #leaflet
  map <- leaflet()
  map <- addTiles(map)
  
  for (i in 1:nrow(lon_lat)){
    lon1 <- as.numeric(lon_lat[i,1])
    lat1 <- as.numeric(lon_lat[i,2])
    vector1 <- cbind(lon1, lat1)
    if (i < nrow(lon_lat)){
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
    map <- addPolylines(map, lng = vector_total[,1], lat = vector_total[,2], col = col)
  }
map
}


