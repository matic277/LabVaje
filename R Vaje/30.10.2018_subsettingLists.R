# generating a list of different types
l = list(
  a = 1:3,
  b = "a string",
  c = pi,
  d = list(-1, -5)
)

x = c(11, 30, 2, 14)

# returns 2nd, 3rd and 4th element
x[2:4]

# returns 4th and 2nd element
x[c(4, 2)]

# gets 4th and 1st element, 0th element does not exist (elements start with 1 not 0)
x[c(4, 0, 1)]

# stores 2nd and 3rd elements as variable y, then replaces them with 17
ii = c(3,2)
y = x[ii]
x[ii] = 17

y
x


# subsetting by name, strings
x = c(janez=11, ana=30, s=2, x=14)

x["janez"]

x[c("janez", "x")]

# selection
x[c(TRUE, FALSE, FALSE, TRUE)]

# negated selection
x[!c(TRUE, FALSE, FALSE, TRUE)]

# if the pattern is shorter, it will be repeated
x[c(TRUE, FALSE, TRUE)]

# return all rows that are > 2
x[x>2]
