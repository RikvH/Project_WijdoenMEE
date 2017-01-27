###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 27 January 2017               ##
###################################

## Function to load, and if necessary install, all packages.

## Input can be a package name (as string) or a vector with the names of the packages (as string).

## If a package does not exist or is not available for this version of R. the function 
## will be aborted and a warning with an error will be displayed.

packageloader <- function(packages){
  
  # Run the function for every desired package.
  for (x in packages){
    
    # Test if package is allready installed.
    if (!(x %in% rownames(installed.packages()))) {
      
      # If not, install the package.
      lapply(x, FUN=install.packages)
    }
   
     # Load the package
    lapply(x, FUN=library, character.only=T)
    
    # print the loaded packages.
    print(paste0("The package '", x, "' is loaded."))
  }
}
