 install.packages("magrittr")
 
 d = cars
 colnames(d)
 d
 
 
 #getting index of culumn name
 grep("dist", colnames(d))
 
 # or
 which(colnames(d)=="dist")
 
 # get values of column "dist"
 d[colnames(d)=="dist"]
