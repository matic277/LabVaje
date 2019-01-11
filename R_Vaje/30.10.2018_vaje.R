# 1 naloga
input = read.table("vaja3_1.txt")

# iz drugega stolpca, ki so: org1, org4... vzamemo stevilko po org substringu in jih damo v svoj stolpec, tretji stolpec
input[ ,3] = gsub("^org(.+)\\|.*", "\\1", input[ ,2])

possibleOrgs = seq_len(max(input[ ,3])) # =c(1,2,3,4)

# zajame vse skupine in vse vrstice, ki se nanasajo na te skupine
# za katere mora pogledati tudi ime organizma
result = vapply(unique(input[ ,1]), function (x) possibleOrgs %in% input[input[ ,1]==x, 3], logical(4))

# vse rezultate zapisemo v poljuben format
result = t(result) * 1
colnames(result) = paste0("org", possibleOrgs)
rownames(result) = unique(input[, 1])
result


# 3 naloga
source("https://bioconductor.org/biocLite.R")
biocLite("Biobase")

# interface for finding file
file = file.choose()

file.exists(file)

expression = read.delim(file)
dim(expression)
head(expression)

data = expression

# print first 5 rows and first 10 columns
data[1:5, 1:10]

# print first 10 rows and all columns
data[1:10, ]

# create a new dataframe that contains just values
subset = data[1:10, ]
class(subset)
subset

# create a new dataframe that has probe IDs as the rownames
rownames(data) = data[, 1]
evals = data[ ,-1]
evals


# 4 naloga
evals = read.delim(file, row.names=1, as.is=TRUE)
dim(evals)
evals[1:10, ]
evals[1:5, 1:10]

# returns 10 random numbers from vector 1:24481 (list of numbers from 1 to 24481)
sample(1:24481, 10)


# 5 naloga
data = read.delim("NKI295.pdata.txt")
