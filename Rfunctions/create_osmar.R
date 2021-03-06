###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 1 February 2017               ##
###################################

## Function that checks whether a base osm is set (loc)
## If it does not exist, create one
## If it does exist, ask to overwrite it (and create a new one)


# Overwrite function
overwrite <- function(ext){
  
  # Ask to create a new osmar object
  n <- readline(prompt = "Do you want to create a new Osmar object? (y/n): ")
  
  # If yes, remove the old osmar object and create a new one
  if (n == "y"){
    rm(loc, inherits= T)
    print("Your osmar object will be created, this might take some time. Please be patient.")
    locat <- setBaseOSM(ext)
    return(locat)
  } 
  
  else if (n == "n"){
    # If no, do nothing
    locat <- loc
    print (" Your osmar object will not be overwritten")
    return(locat)
  } 
  
  else {
    # Give an error
    stop("Incorrect input, 'y' or 'n' expected but not received ")
  } 
  
}


# Check if osmar file is present and when not create a new one

create_osmar <- function(ext){
  
  # If "loc" exists, go to the overwrite function
  if (exists("loc")){
    loc <- overwrite(ext)
    
  }
  
  # If "loc" does not exist, create a new osmar object
  else {
    n <- readline(prompt = "You are about to start creating an osmar object (which is required to calculate the route). 
This might take some time. If not continued automatically, please press 'enter'. ")
    print("Your osmar object will be created, this might take some time. Please be patient.")
    loc <- setBaseOSM(ext)
  }
  return(loc)
}

  