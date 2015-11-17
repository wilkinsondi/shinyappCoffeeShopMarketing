#Require packages
require(shiny)
require(leaflet)

#Generate dataset
names <- c("FlatWhite","TapCoffee","FW","Yumchaa","Foxcroft","Princi","Sacred","SohoGrind",
           "SohoJoe","Algeria","Tapped","Tonic")
reviews <- c(131,28,30,117,77,215,59,16,38,41,8,5)
ratings <- c(4,4,4.5,4,4,4,4,4,4,4.5,4,4)
popularity <- sqrt(reviews)*ratings
placelat <- c(51.513634,51.5154582,51.5129769,51.5152026,51.5129414,51.513846,51.5129446,51.5121446,51.5142755,51.5129833,51.5154582,51.5108185)
placelon <- c(-0.1347613,-0.1358109,-.1364166,-.1361384,-.1341842,-.134522,-.138911,-.1383674,-.1326885,-.1322946,-.1358109,-.1357307)
points <- cbind(placelon,placelat)
rankpop <- as.numeric(rank(-popularity,na.last=TRUE))
#Calc of distances from Oxford Circus
lonox <- c(-0.141921)
lonoxdist <- abs(placelon-lonox)
latox <- c(51.515006)
latoxdist <- abs(placelat-latox)
distfactor <- lonoxdist+latoxdist
rankdist <- as.numeric(rank(distfactor,na.last=TRUE))
# Add into data frame
df <- as.data.frame(c(1:12))
names(df)[1] <-"site"
df <- cbind(df, names,reviews,ratings,popularity,placelat,placelon,rankpop,distfactor,rankdist)
df2 <- subset(df,select=c(popularity,distfactor,reviews,rankpop,rankdist))
