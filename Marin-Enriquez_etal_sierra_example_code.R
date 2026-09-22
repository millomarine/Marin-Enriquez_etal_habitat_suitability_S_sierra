#### Marin-Enriquez et al.: high suitability zones of S. sierra in the Eastern Pacific Ocean ####
library(raster)
library(maps)
library(matlab)
load("yourroute/Marin-Enriquez_etal_sierra_model_data.RData")
#exploring objects:
ls() #env.stack, environmental raster stack. eval, result of the ENMeval evaluation. occs: occurrences, sierra, "raw" data from inaturalist with corrected coordinates (latitude.c, longitude.c)
#simple map of occurrences
x11()
plot(sierra$longitude, sierra$latitude, asp=1) #observed
map(database = "world", add=T, fill=T, col="khaki")
points(sierra$longitude.c, sierra$latitude.c, pch=19)#corrected
#quick view of the environmental data:
plot(env.stack)
#exploring the results of ENMeval
eval

res <- eval@results

res[order(res$AICc), c("fc", "rm", "AICc", "auc.val.avg")]

eval@models[[2]] #the "winner" is model 2. Explore the results.

#predict of HS map
pred <- predict(eval@models[[2]], terra::rast(env.stack))
x11()
plot(pred, col=jet.colors(100))
map(database = "world", add=T, fill=T, col="khaki");box()
