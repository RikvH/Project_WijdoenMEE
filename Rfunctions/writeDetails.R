###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 2 February 2017               ##
###################################


# Function to write route details to an output text file
# Details include: total length, total toughness, average toughness, total height difference 
# (height difference between start and destination), total meters climbed in the route 
# and a route description with meters to travell and direction (in 8 compass directions)

writeDetails <- function(){
  
  # Check if the output file already exists
  if (file.exists("Output/details.txt")){
    # If yes, remove the output file
    file.remove("Output/details.txt")
  }
  
  # Calculate the total number of meters climbed
  totclimb <- 0
  for (i in 1:length(vdist)){
    if (vdist[i] > 0){
      totclimb <- totclimb + (vdist[i])
    }
  }
  
  # Write route details to the output file
  write("Route details:
      ", 
        file = "Output/details.txt", append=T)
  write(paste("The total length of the route is:", round(route_details$cdist[nrow(route_details)], digits = 2), "m."), 
        file = "Output/details.txt", append=T )
  write(paste0("The total toughness of the route is: ", round(sum(tough), digits = 2), "."),
        file = "Output/details.txt", append=T)
  write(paste0("The average toughness of the route is: ", round(mean(tough), digits = 2), "."),
        file = "Output/details.txt", append=T)
  write(paste("The total height difference is:", round(route_details$alt[nrow(route_details)] - route_details$alt[1], 
                                                       digits = 2), "m."),
        file = "Output/details.txt", append=T)
  write(paste("The total amount of meters climbed is:", totclimb, "m.
            
            
            "),
        file = "Output/details.txt", append=T)
  write("Route description:", 
        file = "Output/details.txt", append=T)
  write("", 
        file = "Output/details.txt", append=T)
  for (row in nrow(copy)){
    write(paste0(copy$way_names, ": cycle ", round(copy$dist, digits=2), " m to the ", copy$dir, "."), 
          file="Output/details.txt", append=T)
  }
}
