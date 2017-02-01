

overwrite <- function(){
  n <- readline(prompt = "Do you want to over write the Osmar object? (y/n) ")
  
  if (n == "y"){
    log <- setBaseOSM(ext)
  } 

  else if (n == "n"){
    print (" Your osmar object will not be overwritten")
  } 
  
  else {
   print ("Warning! Invalid input, please type 'y' or 'n'")
    answer()
} 
  
}


create_osmar <- function(){
  if (exists("log")){
  overwrite()
  }
  else 
    a <- 5
}
