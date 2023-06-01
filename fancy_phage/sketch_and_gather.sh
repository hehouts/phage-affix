sourmash sketch dna -p k={k},scaled=1,abund -o sigs/SM_CTTKX.k{k}.sig data/SM_CTTKX.trim.fq.gz

sourmash gather \
sigs/SM_CTTKX.k{k}.sig sigs/{phage}.k{k}.fa.sig \
--threshold-bp 1 #\


#-o gather/gather.{k}.csv \
#--save-matches gather/matches.txt \
#--save-prefetch-csv gather/prefetch.csv







### Working For One Sample version:

#sourmash sketch dna -p k=21,scaled=1,abund -o sigs/SM_CTTKX.trim.sig data/SM_CTTKX.trim.fq.gz

#sourmash gather \
#sigs/SM_CTTKX.trim.sig sigs/ivig_358.k21.fa.sig \
#--threshold-bp 1 \
#-o gather/gather.csv \
#--save-matches gather/matches.txt \
#--save-prefetch-csv gather/prefetch.csv







####notes from grist era, probably delete:
#taxonomies
#- /group/ctbrowngrp/virus-references/gut-phage-db/GPD_metadata.tsv

#smash db
#/group/ctbrowngrp/virus-references/gut-phage-db/GPD_sequences.zip