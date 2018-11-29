# shrani podatke v direktorid getwd() - (za ogled trenutnega working directory)
# x = data source
# file = ime_datoteke
data = airquality
data_name = "airquality"
file_name = "data_output.csv"
cat("Exporting ", file_name, " to ", getwd(), "/", file_name)
write.csv(x = data, file = file_name)

# to rds (native R data file)
file_name = "data_output.rds"
write.table(x = data, file = file_name)

# to xlsx
install.packages("writexl")
writexl::write_xlsx(x = data, path = "./excel_output.xlsx")

# to gz
write.csv(x = data, file = gzfile("excel_compressed2.xlsx.gz"))


# reading xlsx files (excel files)
# and timing how long it takes
install.packages("readxl")
install.packages("openxlsx")

# opening with read_excel
t0 = Sys.time()
data = readxl::read_excel(path = "C:/Users/famnit/Documents/NYCTaxi.xlsx")
t1 = Sys.time()
cat("Time spent reading: ", (t1-t0), " seconds")
summary(data)

# opening with openxlsx
t0 = Sys.time()
data = openxlsx::openXL(file = "C:/Users/famnit/Documents/NYCTaxi.xlsx")
t1 = Sys.time()
cat("Time spent reading: ", (t1-t0), " seconds")
summary(data)

# opening with rio
install.packages("rio")
t0 = Sys.time()
data = rio::import(file = "C:/Users/famnit/Documents/survey.zip")
t1 = Sys.time()
cat("Time spent reading: ", (t1-t0), " seconds")
summary(data)


