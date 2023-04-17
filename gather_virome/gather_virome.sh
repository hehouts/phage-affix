sourmash sketch dna -p scaled=100,k=21,k=31,abund SM_CTTKX.abundtrim.fq.gz 

# Gut Phage db gather
sourmash gather SM_CTTKX.abundtrim.fq.gz.sig \
/group/ctbrowngrp/virus-references/gut-phage-db/GPD_sequences.zip \
-k 21 \
--threshold-bp 100 \
--scaled 100 \
-o matches.csv

# GTDB gather
#sourmash gather SM_CTTKX.abundtrim.fq.gz.sig \
#~/databases/gtdb-rs202.genomic-reps.k31.sbt.zip \
#-k 31 --threshold-bp 100 -o matches.csv


