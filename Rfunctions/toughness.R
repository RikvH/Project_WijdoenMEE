###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 31 January 2017               ##
###################################

# Fuction to calculate the toughness of the route for each section of the route
# Vertical distance travelled is divided by the horizontal distance traveled


toughness <- function(vdist, hdist){
  
  hdist <- as.vector(hdist)
  hdist <- hdist[-1]
  
  
  # Check if the length of the vdist and hdist vectors are equal if not abort
  if (length(vdist) != length(hdist)){
    stop("length is not equal")
  } else {
    
    # Divide negative values in the vdist by 2. Negative values indicate a downhill sections
    # and these weigh less then uphill sections
    for (i in 1:length(vdist)){
      if (vdist[i] < 0){
        vdist[i] = vdist[i]/2
      } 
    }
    
    # Calculate the toughness for each section
    toughness <- (vdist/ hdist)
  }
}


