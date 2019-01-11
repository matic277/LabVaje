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




