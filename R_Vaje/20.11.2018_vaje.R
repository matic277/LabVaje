# install.packages("seqinr")
library(seqinr)

# basic seqinr functions:

# explode string to vector of characters
s2c()

# or the other way around
c2s()

# ?
translate()

# convert one-letter amino-acid code into the three-letter one, for instance "A" into "Ala"
aaa()

# reading FASTA formatted files
read.fasta()
write.fasta()


# onverting to upper or to lower chars
toupper("actg")
tolower("ACTG")

toupper(s2c("actg"))
tolower(c2s(c("A", "C", "T", "G")))

choosebank("swissprot")

s1 = query("s1", "AC=Q9CD83")
s1seq = getSequence(s1$req[[1]])

s2 = query("s2", "AC=A0PQ23")
s2seq = getSequence(s2$req[[1]])

s1$req[[1]]

s1

l = list(s1, s2)
names(l) = c("Q9CD83", "A0PQ23")

l$Q9CD83
l$A0PQ23

names(l$Q9CD83)

sapply(l, function(x) x$req)

# FASTA format

# header only (first line)
header = readLines("sequence.fasta", n=1)
header

# reading sequence but leaving header out
data1 = readLines("sequence.fasta")
data1 = data1[-1]


data2 = readLines("NC_001477.fasta")
data2 = data2[-1]

# dumb conversion
data = c2s(data)
data = s2c(data)
class(data)


length(data)
data

# count number of occurances of each letter
table = table(data)

# occurances of a letter by % (frequences)
tablePercent = table / length(data)
tablePercent


freqA = tablePercent["A"]
freqT = tablePercent["T"]
freqG = tablePercent["G"]
freqC = tablePercent["C"]

probabilities = c(freqA, freqC, freqG, freqT)
probabilities



library("seqinr")
dengue = read.fasta("NC_001477.fasta")
dengueseq = dengue[[1]]
dengueseq

query(dengueseq, "AC=NC_001477")

attributes(dengueseq)


choosebank("refseq")
s1 = query("s1", "AC=NC_000117")
closebank()
s1


# installing bioconductor and biostrings
if (!requireNamespace("BiocManager"))
  install.packages("BiocManager")
BiocManager::install("Biostrings")

library("Biostrings")

sigma = nucleotideSubstitutionMatrix(match=2, mismatch=-1, baseOnly=TRUE)
sigma



s1seqstring = c2s(data1)
s2seqstring = c2s(data2)

s1seqstring = toupper(s1seqstring)
s2seqstring = toupper(s2seqstring)

data("BLOSUM50")

globalAllign = pairwiseAlignment(
  s1seqstring,
  s2seqstring,
  substitutionMatrix=BLOSUM50,
  gapOpening = -2,
  gapExtension = -8,
  scoreOnly = FALSE
)

globalAllign
