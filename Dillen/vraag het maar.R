

overwrite <- function(){
  n <- readline(prompt = "Do you want to over write the Osmar object? (y/n) ")
  
  if (n == "y"){
    a <- 6
  } 

  else if (n == "n"){
    print (" Your osmar object will not be overwritten")
  } 
  
  else {
    stop ("Incorrect input")
   # print ("Warning! Invalid input, please type 'y' or 'n'")
   #  answer()
}
  
}


create_osmar <- function(){
  if (exists("b")){
  overwrite()
  }
  else 
    n <- readline(prompt="test")
    b <- 5
}
