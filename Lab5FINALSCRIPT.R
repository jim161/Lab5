library("lubridate")
library("plyr")
library("stringr")
library("pastecs")
library("oce")
library("measurements")

#Added measurements package
install.packages("measurements")

#ARC GIS Date Fromatting. (Date stringing and Decimal Formatting)

GOM$Month <- sprintf("%02d", GOM$Month)
GOM$Day <- sprintf("%02d", GOM$Day)
GOM$GISDATE <- str_c(GOM$Year, GOM$Month, GOM$Day, sep ="-")

Alaska$month <- sprintf("%02d", Alaska$month)
Alaska$GISDATE <- str_c(Alaska$Year, Alaska$month, "00", sep = "-")

#Remove S W and degrees from Coordinates

Peru$LONGDec <- gsub("W", "", Peru$LONG)
Peru$LATDec <- gsub("S", "", Peru$LAT)

Peru$LONGDec <- gsub("°", " ", Peru$LONGDec)
Peru$LATDec <- gsub("°", " ", Peru$LATDec)



#Convert to Decimal Degrees
Peru$LONGDec <- measurements::conv_unit(Peru$LONGDec, from = 'deg_dec_min', to = 'dec_deg')
Peru$LATDec <- measurements::conv_unit(Peru$LATDec, from = 'deg_dec_min' , to = 'dec_deg')


#Make Coordinates Numeric
Peru$LONGDec <- as.numeric(Peru$LONGDec)
Peru$LATDec <- as.numeric(Peru$LATDec)

Peru$LONGDec <-Peru$LONGDec* -1
Peru$LATDec <-Peru$LATDec* -1
Peru2012 <- Peru[Peru$year==2012,]

write.table(Peru2012, "Peru2012.txt", sep="\t", row.names =FALSE, col.names=TRUE)
write.table(Alaska, "Alaska.txt", sep="\t", row.names =FALSE, col.names=TRUE)
write.table(GOM, "GOM.txt", sep="\t", row.names =FALSE, col.names=TRUE)
write.table(Peru, "Peru.txt", sep="\t", row.names =FALSE, col.names=TRUE)

