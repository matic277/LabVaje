# matrix: Exercise 1
x = c(1, 0, 0)
y = c(0, 1, 0)
z = c(0, 0, 1)

m = matrix(data=c(x,y,z), 3, 3)
colnames(m) = c("a", "b", "c")
m
# matrix: Exercise 2
is.matrix(m)

# matrix: Exercise 3
vec = c(1:12)
mtr = matrix(data=vec, nrow=4, ncol=3, byrow=TRUE)
colnames(mtr) = c("x", "y", "z")
rownames(mtr) = c("a", "b", "c", "d")
mtr
