###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 2 February 2017               ##
###################################

# Function that defines the classes based on the toughness
# The classes are manually defined

classes <- function(tough){

  class <- c(NULL)
  for (i in 1:length(tough)) {
    if (tough[i] == 0){
      class[i+1] <- "flat terrain"
    } else if (tough[i] > -0.15 & tough[i] < 0){
      class[i+1] <- "downhill"
    } else if (tough[i] > -0.35 & tough[i] <= -0.15){
      class[i+1] <- "rather steep downhill"
    } else if (tough[i] <= -0.35){
      class[i+1] <- "steep downhill"
    } else if (tough[i] > 0 & tough[i] <= 0.3){
      class[i+1] <- "uphill"
    } else if (tough[i] > 0.3 & tough[i] <= 0.7){
      class[i+1] <- "rather steep uphill"
    } else{
      class[i+1] <- "steep uphill"
    }
  }
return(class)
}