###################################
## Wij doen MEE                  ##
## Rik van Heumen & Dillen Bruil ##
## 1 February 2017               ##
###################################

# Function to automatically download the correct AHN data and reproject this to wgs84

download_ahn <- function(ext){
  
  # Define CRS for RD New (AHN) and WGS84 (graph)
  crs.rdnew <- CRS("+proj=somerc +lat_0=52.1561601 +lon_0=5.38763889 +ellps=bessel +x_0=155000 +y_0=463000 +towgs84=[565.417,50.3319,465.552,-0.398957,0.343988,-1.8774,4.0725 +units=m +k_0=1 +no_defs")
  crs.wgs84 <- CRS("+init=epsg:4326")
  
  # Reproject the coordinates of the extent to RD New
  wgs84 <- data.frame(lon=c(ext[2]-0.03, ext[2]+0.03), lat=c(ext[1]-0.03, ext[1]+0.03))
  coordinates(wgs84) <- c('lon', "lat")
  proj4string(wgs84) <- crs.wgs84
  rdnew <- spTransform(wgs84, crs.rdnew)
  
  # Extract the coordinates for the AHN to download
  lat_min <- round(as.numeric(rdnew@coords[1,2]))
  lat_max <- round(as.numeric(rdnew@coords[2,2]))
  lon_min <- round(as.numeric(rdnew@coords[1,1]))
  lon_max <- round(as.numeric(rdnew@coords[2,1]))

  # Download and open the AHN
  url <- paste0("http://geodata.nationaalgeoregister.nl/ahn2/wms?version=1.3.0&service=WMS&request=GetMap&LAYERS=ahn2_05m_int&style=ahn2_05m_detail&WIDTH=3000&HEIGHT=3000&bbox=", 
                       lon_min, ",", lat_min, ",", lon_max, ",", lat_max, "&CRS=EPSG:28992&FORMAT=image/geotiff")
  download.file(url, destfile="Data/AHN.tif", mode="wb")
  ahn_rdnew <- brick("Data/AHN.tif")
  plot(ahn_rdnew, legend=T, grid=T)
  # Project the raster to WGS84
  ahn <- project(from = ahn_rdnew, crs = crs.wgs84)
}

