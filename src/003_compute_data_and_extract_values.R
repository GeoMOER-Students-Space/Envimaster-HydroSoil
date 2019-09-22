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
libs = c("link2GI") 
pathdir = "repo/src"

#set root folder for uniPC or laptop                                                        #
root_folder = alternativeEnvi(root_folder = "~/edu/Envimaster-HydroSoil",                    #
                              alt_env_id = "COMPUTERNAME",                                  #
                              alt_env_value = "PCRZP",                                      #
                              alt_env_root_folder = "F:/edu/Envimaster-HydroSoil")           #
#source environment script                                                                  #
source(file.path(root_folder, paste0(pathdir,"/001_setup_hydro_withSAGA_v1.R")))                                                              
###---------------------------------------------------------------------------------------###
#############################################################################################

# compute slope and aspect layer for extraction Values at positions


# load data
#dem <- raster::raster(file.path(envrmt$path_001_org,"dem_mof.tif"))
plts<-rgdal::readOGR(file.path(envrmt$path_001_org,"xxx.shp"))
#set paths
tmp <- envrmt$path_tmp
utm<-"+proj=utm +zone=32 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
plts<-spTransform(plts,utm)
crs(plts)
################################################################################

################################################################################
#source functions
#source(file.path(root_folder, file.path(pathdir,"LEGION_dem/LEGION_dem_v1.4/LEGION_dem_v1_4.R")))
#source(file.path(root_folder, file.path(pathdir,"LEGION_dem/LEGION_dem_v1.4/sf_LEGION_dem_v1_4.R")))
source(file.path(root_folder, file.path(pathdir,"REAVER_extraction/REAVER_extraction_v1.1/000_Reaver_extraction_v1.1.R")))
################################################################################
#test LEGION_dem release

#load data
#stk_mof <- LEGION_dem(dem = dem,tmp = tmp,proj = utm)
#slop <- stk_mof$slope
#asp <- stk_mof$aspect

#writeRaster(slop,file.path(envrmt$path_002_processed,"slope.tif"))
#writeRaster(asp,file.path(envrmt$path_002_processed,"aspect.tif"))

# outcommended after written out rasters for further use, deleted tmp folder

# extract values

#load data
dem <- raster::raster(file.path(envrmt$path_001_org,"dem_mof.tif"))
slp <- raster::raster(file.path(envrmt$path_002_processed,"slope.tif"))
asp <- raster::raster(file.path(envrmt$path_002_processed,"aspect.tif"))
stk <- stack(dem,slp,asp)

df <- Reaver_extraction(poly=plts,multilayer = stk,set_ID = T,name = "hydro")
