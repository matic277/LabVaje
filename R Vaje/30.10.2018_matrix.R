m = matrix(1:15, nrow=3, byrow=TRUE)
dim(m)

# get number of rows or cols
nrow(m)
ncol(m)

# set row or col names
colnames(m) = letters[4:8]
rownames(m) = letters[1:3]
m

# resizing matrix, will repeat the pattern of elements again

# get 1:2 (first two) rows only (with all columns)
m[1:2, ]

# get 3rd and 4th columns (with all rows)
m[ ,3:4]

# get 2x2 matrix of 2nd and 3rd rows with 4th and 3rd columns
m[c(2,3), c(4,3)]

