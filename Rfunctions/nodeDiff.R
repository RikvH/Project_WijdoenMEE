###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 30 January 2017               ##
###################################

# Function to calculate the difference in height between every node
# The differences are returned as a vector

nodeDiff <- function(alt){
  
  # Create empty vector
  diff <- vector()
  
  # Go over every node
  for (i in 1:length(alt)-1){
    
    # Calculate the height difference between the next and the current node and add it to the vector
    diff[i] <- (alt[i+1]-alt[i])
  }
  
  # Return the vector outside the for loop
  return (diff)
}

