#Part 1, creating Download.R, and experimenting with entrez_fetch

install.packages("rentrez") #installing rentrez, script would not run without quotations marks

ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") #creates an object of 3 characters which are the unique NCBI IDs of rRNA sequences that we're going to search
library(rentrez)
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")
#fetches nucleotide sequences which have the same NCBI id as the previous  and creates a FASTA formatted data, which represents a part of an rRNA gene from Borrelia burgdoferi. 
print(Bburg)
str(Bburg)

Bburg1 = entrez_fetch(db = "nuccore", id = "HQ433692.1", "HQ433694.1" rettype = "fasta")
print(Bburg1)

Bburg2 = entrez_fetch(db = "nuccore", id = "HQ433692.1", "HQ433694.1" rettype = "fasta") #doesn't work

Bburg3 = entrez_fetch(db = "nuccore", id = c("HQ433692.1","HQ433694.1","HQ433691.1"), rettype = "fasta")
print(Bburg3) #this works, so usind c() inside will work the function, which might make things more simple

Bburg4 = entrez_fetch(db = "nuccore", id = c("HQ433692.1","HQ433694.1","HQ433691.1"), rettype = "xml")
print(Bburg4) #xml is not friendly on the eyes, I'll stick to fasta

?strsplit
sequences = strsplit(Bburg, split = ">")
sequences

Sequences = unlist(sequences)
Sequences

header = gsub("(^>.*sequence)\\n[ATCG].*", "\\1", Sequences)
seq = gsub("^>.*sequence\\n([ATCG].*)", "\\1", Sequences)
Sequences1 = data.frame(Name=header,Sequence=seq)
Sequences1

write.csv(Sequences, file = "Sequences")
Sequences
