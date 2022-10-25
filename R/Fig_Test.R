#need to modify download.file function to increase timeout because the FIA Mart is super slow
options(timeout=3600)
library(rgdal)
library(rFIA)
source("./R/readWriteGet.R")

fiaIN <- readFIA("/Users/malbarn/OneDrive - Indiana University/Proposals/2022_NASA_CMS/Figs/IN/", state="IN")
str(fiaIN)
shape <- readOGR("/Users/malbarn/OneDrive - Indiana University/Proposals/2022_NASA_CMS/Figs/FIA_Forest_Biomass_Estimates_1873/data/CONUSbiohex2020/CONUSbiohex2020.shp")


riMR <- clipFIA(fiaIN)
riall <- clipFIA(fiaIN,44)
findEVALID(fiaIN)
tpaRI <- tpa(fiaIN)
biomassRI <- biomass(fiaIN, returnSpatial = TRUE, tidy=FALSE)
plotFIA(biomassRI, BIO_ACRE)


fiaIN$COND$STDAGE[fiaIN$COND$STDAGE < 0] <- NA
makeClasses(fiaIN$COND$STDAGE, interval = 25)

bio_pltSF <- biomass(fiaIN, byPlot=TRUE, returnSpatial = TRUE)
plot(bio_pltSF['BIO_ACRE'])
plotFIA(bio_pltSF, y=BIO_ACRE)
bio_polys <- biomass(riMR, polys=shape, returnSpatial = TRUE)
plotFIA(bio_polys, y=JENK_LIVE)
plotFIA(bio_polys, y=SE_JENK_LI)
