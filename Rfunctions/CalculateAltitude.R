####
#Function to calculte the altitude graph
####


wag_poly <- as_sp(route_wag, "points")
plot(wag_poly)


altitude <- function(routepoints){
  projroute <- spTransform(routepoints, CRS(proj4string(ned)))
  alt <- extract(nedcrop, projroute, along = TRUE)
  min <- min(alt)
  min
  max <- max(alt)
  max
  plot(alt, type = 'l', ylab = "Altitude (m)")
}






