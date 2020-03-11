library(pacman)
p_load(tidyverse, raster, reshape2, ggplot2, rayshader)

#load raster
ras <- read_rds("crime_ras.RDS")
#convert to matrix
mat <- raster_to_matrix(ras)
#make ggplot object
ggcrime = mat %>% 
  melt() %>%
  ggplot() +
  geom_tile(aes(x = Var1, y = Var2, fill = value)) +
  geom_contour(aes(x = Var1, y = Var2, z = value), color = "black") +
  scale_x_continuous("X", expand = c(0, 0)) +
  scale_y_continuous("Y", expand = c(0, 0)) +
  scale_fill_gradientn("Z", colours = terrain.colors(10)) +
  coord_fixed()
#look at ggplot object
ggcrime
#make rayshader 3d
plot_gg(ggcrime, multicore = TRUE, raytrace = TRUE, width = 7, height = 4, 
        scale = 300, windowsize = c(1400, 866), zoom = 0.6, phi = 30, theta = 30)
