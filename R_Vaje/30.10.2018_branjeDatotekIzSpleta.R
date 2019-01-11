# branje datoteke iz naslova, header je prva vrstica 'force', ki poimenuje stolpec
data = read.table("https://www.star.le.ac.uk/sav2/waves.dat", header=TRUE)

summary(data)

# dodajanje nove vrstice z imenom 'x'
# dodamo samo stevilke od [1,320]
data$x = 1:320

# zapisemo data v datoteko data.txt v workingdirectory
# vsaka vrstica se zacne z "st_vrstice" -> "1", "2", ....
write.table(data, "data.txt")

# brez zapisov stevilke vrstic
write.table(data, "data_rowless.txt", row.names = FALSE)


# graficni izris podatkov
x = data$x
y = data$force

# type=l poveze pike med sabo...
plot(x, y, type="l")

# branje iz excel datotek
