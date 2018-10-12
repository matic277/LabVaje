#Lab
vec = c(1:100)
lst = list(1:10)
mtr = matrix(nrow=10, ncol=5)
lst2 = list("fst", "snd", "trd", "frt", "fth")

vec
lst
mtr
lst2

df = as.data.frame(1:10)
df = cbind(df, c(11:20))
df = cbind(df, c(21:30))
df = cbind(df, c(31:40))

colnames(df) = c("1", "2", "3", "4")
df

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

# factors: Exercise 1
x = c(1, 2, 3, 3, 5, 3, 2, 4, NA)
factor(x)
  # -> a

# factors: Exercise 2
x <- c(11, 22, 47, 47, 11, 47, 11)
factor(x, levels=c(11, 22, 47), ordered=TRUE)
  # -> c

# factors: Exercise 3
z <- c("p", "a" , "g", "t", "b")
z[3] = "b"
  # -> c

# factors: Exercise 3
z <- factor(c("p", "q", "p", "r", "q"))