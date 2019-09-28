#############################################################################################
###--- Setup Environment -------------------------------------------------------------------#
                                  ###############################################           #
# require libs for setup          #EEEE n   n v       v rrrr    m     m   ttttt #           #                  
require(raster)                   #E    nn  n  v     v  r   r  m m   m m    t   #           #         
require(envimaR)                  #EE   n n n   v   v   rrrr   m m   m m    t   #           #                
require(link2GI)                  #E    n  nn    v v    r  r  m   m m   m   t   #           #             
                                  #EEEE n   n     v     r   r m    m    m   t   #           #
                                  ###############################################           #
                                                                                            #
# define needed libs and src folder                                                         #
libs = c("link2GI","plyr","mapview") 
pathdir = "repo/src"

#set root folder for uniPC or laptop                                                        #
root_folder = alternativeEnvi(root_folder = "~/edu/Envimaster-HydroSoil",                    #
                              alt_env_id = "COMPUTERNAME",                                  #
                              alt_env_value = "PCRZP",                                      #
                              alt_env_root_folder = "F:/edu/Envimaster-HydroSoil")           #
#source environment script                                                                  #
source(file.path(root_folder, paste0(pathdir,"/001_setup_hydro_v1.R")))                                                              
###---------------------------------------------------------------------------------------###
#############################################################################################

# scfipt to extract values for plot positions

#load data

pts <-rgdal::readOGR(file.path(envrmt$path_002_processed,"merged_points.shp"))
crs(pts)
utm <- "+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
pts<-spTransform(pts,utm)
crs(pts)

slp  <-raster::raster(file.path(envrmt$path_002_processed, "slope.tif"))
asp  <-raster::raster(file.path(envrmt$path_002_processed, "aspect.tif"))
dem <- raster::raster(file.path(envrmt$path_001_org, "DEM_mof.tif"))

stk<- raster::stack(slp,asp,dem)


#source 
source(file.path(root_folder, file.path(pathdir,"REAVER_extraction/REAVER_extraction_v1.1/dev_Reaver_extraction_points_v1.R")))

test <- Reaver_extraction_point(pts,stk,set_ID = TRUE)
test
mapview::mapview(pts)+dem
