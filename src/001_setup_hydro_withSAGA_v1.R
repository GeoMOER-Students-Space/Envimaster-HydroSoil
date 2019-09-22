### Setup project folders and set root dir

# Set project specific subfolders
cat("#--- set Folders ---#",sep = "\n")
project_folders = c("data/",                                
                    "data/001_org/",
                    "data/002_processed/",
                    
                    #local data not in repo
                    "tmp/", # tmp folder for saga data
                    "GIS/",
                    "repo/doc/",   #for scripts
                    "repo/img/",   #for docs
                    "repo/lit/",   #for literature
                    "repo/src/",
                    "repo/TMP_bin",
                    "repo/src/LEGION_dem/"
                    
                    
)

# Automatically set root direcory, folder structure and load libraries
cat("#--- set up Environment  ---#",sep = "\n")
envrmt = createEnvi(root_folder = "~/edu/Envimaster-HydroSoil", 
                    folders = project_folders, 
                    path_prefix = "path_", libs = libs,
                    alt_env_id = "COMPUTERNAME", alt_env_value = "PCRZP",
                    alt_env_root_folder = "F:/edu/Envimaster-HydroSoil/")

cat("#--- use '(file.path(envrmt$...) to set path to folderstructure ---#",sep = "\n")


cat("#--- linking SAGA  ---#",sep = "\n")
cat("#--- this could take a while  ---#",sep = "\n")
saga<-linkSAGA(ver_select = TRUE)
env<-RSAGA::rsaga.env(path = saga$sagaPath)

rm(libs)
cat(" ",sep = "\n")
cat(" ",sep = "\n")
cat(" ",sep = "\n")


cat("EEEE n   n v       v rrrr    m     m   ttttt ",sep = "\n")
cat("E    nn  n  v     v  r   r  m m   m m    t   ",sep = "\n")
cat("EE   n n n   v   v   rrrr   m m   m m    t   ",sep = "\n")
cat("E    n  nn    v v    r  r  m   m m   m   t   ",sep = "\n")
cat("EEEE n   n     v     r   r m    m    m   t   ",sep = "\n")
cat("                         with SAGA           ",sep = "\n")
cat("                         for HydroSoil ready",sep = "\n")

