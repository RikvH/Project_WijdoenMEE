classes <- function(tough){

  class <- c(NULL)
  for (i in 1:length(tough)) {
    if (tough[i] == 0){
      class[i+1] <- "flat terrain"
    } else if (tough[i] > -0.1 & tough[i] < 0){
      class[i+1] <- "downhill"
    } else if (tough[i] > -0.3 & tough[i] < 0){
      class[i+1] <- "rather steep downhill"
    } else if (tough[i] < -0.3){
      class[i+1] <- "steep downhill"
    } else if (tough[i] < 0.1){
      class[i+1] <- "uphill"
    } else if (tough[i] < 0.3){
      class[i+1] <- "rather steep uphill"
    } else{
      class[i+1] <- "steep uphill"
    }
  }
return(class)
}