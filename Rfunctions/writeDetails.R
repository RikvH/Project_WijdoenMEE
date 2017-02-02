###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 2 February 2017               ##
###################################


# Function to write route details to an output text file
# Details include: total length, total toughness, average toughness, total height difference 
# (height difference between start and destination), total meters climbed in the route 
# and a route description with meters to travell and direction (in 16 compass directions)

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
  
  # Make local copy of the route_details and remove the first line
  copy <- route_details
  copy <- copy[-c(1),]
  
  
  # Write route details to the output file using html commands
  cat("Route details:", "<br>",  "<br>", 
        file = "Output/details.txt", append=T)

  cat(" The total length of the route is:", round(route_details$cdist[nrow(route_details)], digits = 2), "m.",  "<br>", 
        file = "Output/details.txt", append=T )
  cat(paste0(" The total toughness of the route is: ", round(sum(tough), digits = 2), "."), "<br>", 
        file = "Output/details.txt", append=T)
  cat(paste0(" The average toughness of the route is: ", round(mean(tough), digits = 2), "."), "<br>", 
        file = "Output/details.txt", append=T)
  cat(paste(" The total height difference is:", round(route_details$alt[nrow(route_details)] - route_details$alt[1], 
                                                       digits = 2), "m."), "<br>", 
        file = "Output/details.txt", append=T)
  cat(paste(" The total amount of meters climbed is:", totclimb, "m."), "<br>",  "<br>",  "<br>", 
        file = "Output/details.txt", append=T)
  
  cat("Route description:",  "<br>", "<br>",
        file = "Output/details.txt", append=T)
  for (row in nrow(copy)){
    cat(paste0(copy$way_names, ": cycle ", round(copy$dist, digits=2), " m to the ", copy$dir, ".<br>"),   
          file="Output/details.txt", append=T)
  }
}
