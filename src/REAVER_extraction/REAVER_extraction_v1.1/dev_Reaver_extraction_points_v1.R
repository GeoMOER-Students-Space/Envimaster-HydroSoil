#' Mandatory: Reaver Extraction
#' 
#' @description Optional: Function to extract values from multilayer objects for several spatial polygons
#' and calculate multiple statistic values with one value per polygone. returns a single data frame.
#' @name Mandatory Reaver 
#' @export Mandatory Reaver

#' @param Mandatory if function: pts - a shp with spatial points
#' @param Mandatory if function: multilayer - a rasterbrick, needs same CRS and extensions like the shp
#' @param Mandatory if function: set_ID - bolean, if TRUE an ID is added to the polygones, default is TRUE
#' @param Mandatory if function: stats - bolean, if TRUE returns a data frame with sd,mean,sum,min and max values for each polygone, default is TRUE
#' @param Mandatory if function: spell - bolean, if TRUE the function will call the workflow position, default is TRUE
#' @param Mandatory if function: name - character in "" - paste a name to the Object ID, default is "" empty.

#note: v1.1 now paste a name to the object ID, renewed structur

Reaver_extraction_point <- function(pts,multilayer,set_ID=TRUE,name="") {
  
  #infun Test###
  pts=pts
  multilayer=dem
  ###############
  
 
  cat(" ",sep = "\n")
  cat("### Reaver starts Extraction of Values ###")
  cat(" ",sep = "\n")

  #add ID column
  if (set_ID==TRUE){
    pts@data$ID=seq(1,length(pts),1)
  }else{
    pts=pts  } #if input data has a defined "ID" column
  require(mapview)
  mapview::mapview(pts)+dem
  plot(rastrize)
  #rasterize polygones , mask the multilayer to rasterized polygones and add the rasterized polygone 
  cat(" ",sep = "\n")
  cat("### Reaver rasterizes the points for",nlayers(multilayer),"Layers ###")
  rastrize <- raster::rasterize(pts,multilayer,field="ID")
  masked <- raster::mask(multilayer,rastrize)
  masked_ID <- raster::addLayer(masked,rastrize)
  
  #extract Values , handle NA and get df
  cat(" ",sep = "\n")
  cat("### Reaver extracts the Values from ",nlayers(multilayer),"Layers ###")
  getval <- raster::getValues(masked_ID)
  clean <- na.omit(getval)
  df_clean <- as.data.frame(clean)
  return(df_clean)
    
} 
#'@examples
#'\dontrun{
###load data 
#'poly <-readOGR(file.path(envrmt$path_Reaver,"expl_poly.shp"))
#'poly
#'crs(poly)
#'poly<-spTransform(poly,utm)
#'# load artificially layers
#'slope <-raster::raster(file.path(envrmt$path_Reaver, "expl_slope.tif"))
#'aspect<-raster::raster(file.path(envrmt$path_Reaver, "expl_aspect.tif"))
#'cov_min<-raster::raster(file.path(envrmt$path_Reaver, "expl_cov_min.tif"))
#'cov_max<-raster::raster(file.path(envrmt$path_Reaver, "expl_cov_max.tif"))
#'# create brick
#'brck <- raster::brick(slope,aspect,cov_min,cov_max)
#'brck
#'###run Reaver
#'df<- Reaver(poly=poly,multilayer=brck,set_ID = TRUE,name="test)
#'df
#'}


