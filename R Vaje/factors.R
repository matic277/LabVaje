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

# factors: Exercise 4
z <- factor(c("p", "q", "p", "r", "q"))
levels(z)[levels(z)=="p"] = "w"
z

# factors: Exercise 5
s1 <- factor(sample(letters, size=5, replace=TRUE))
s2 <- factor(sample(letters, size=5, replace=TRUE))
# solution 1 (stackoverflow)
unlist(list(s1, s2))
# solution 2 (convert to chars then factor)
factor(c(as.character(s1), as.character(s2)))

# factors: Exercise 6
v = iris$Sepal.Length
v1 = cut(v, breaks=seq(from=4.3, to=7.9, by=0.72))
summary(factor(v1))
#levels(v1)

# factors: Exercise 8
x <- data.frame(q=c(2, 4, 6), p=c("a", "b", "c"))
levels(x$p) = c("fertiliser1", "fertliser2", "fertiliser3")
levels(x$p)
x


# end of exercises
str(x)
dim(x)
class(x)