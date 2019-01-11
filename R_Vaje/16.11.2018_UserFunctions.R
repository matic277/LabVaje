# defining global variables
g <<- 10

# Exercise 1
# Create a function to print square of number

pow2 = function(n) {
  n^2
}

pow2(5)

# Exercise 2
# Create a function to print a number raise to another with the one argument a default argument

pow = function(n, m=3) {
  n^m
}

pow(2,4)
pow(2)

# Exercise 3
# Create a function to print class of an argument

classOf = function(e) {
  class(e)
}

classOf(c(1:3))

# Exercise 4
# Create a function that given a vector and an integer will return how many times the integer appears inside the vector.

count = function(v, n) {
  c = 0;
  for (e in v) if (e == n) c = c+1
  c
}

count(c(1:10, 1:10), 2)

# Exercise 5
# Create a function that given an integer will calculate how many divisors it has (other than 1 and itself).
# Make the divisors appear by screen.

divisors = function(n) {
  numOf = 0
  divs = c(2:(n/2))
  for (d in divs) if (n%%d == 0) {
      print(d)
      numOf = numOf + 1
  }
  print(paste("Number of divisors: ", numOf))
}

divisors(20)


# number of each element in vector
howmany = function(e) {
  v = sample(1:8, 10, replace=TRUE)
  print(paste("Element e: ", e))
  print("Random v: ")
  print(v)
  
  print(length(v[v==e]))
}

sapply(1:10, howmany)

