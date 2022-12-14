
#  ███████╗    ███╗   ██╗     █████╗     ██╗  ██╗    ███████╗    ███████╗    ██╗    ██╗         ███████╗
#  ██╔════╝    ████╗  ██║    ██╔══██╗    ██║ ██╔╝    ██╔════╝    ██╔════╝    ██║    ██║         ██╔════╝
#  ███████╗    ██╔██╗ ██║    ███████║    █████╔╝     █████╗      █████╗      ██║    ██║         █████╗  
#  ╚════██║    ██║╚██╗██║    ██╔══██║    ██╔═██╗     ██╔══╝      ██╔══╝      ██║    ██║         ██╔══╝  
#  ███████║    ██║ ╚████║    ██║  ██║    ██║  ██╗    ███████╗    ██║         ██║    ███████╗    ███████╗
#  ╚══════╝    ╚═╝  ╚═══╝    ╚═╝  ╚═╝    ╚═╝  ╚═╝    ╚══════╝    ╚═╝         ╚═╝    ╚══════╝    ╚══════╝



# this required sourmash, spacegraph cats, ncbi-datasets-cli (not entrez direct or ncbi-acc-download, it didnt work)


# ██████████ THIS PART ██████████

#this totally has redundancies, theres actually only 5 unique ones

# actually, I could probably make 'PHAGES' and 'HOSTS' by defining them from the key / val method(? object?) of the HOST_RANGES dictionary 

#PHAGES = ['uvig_409809']
#PHAGES = ['uvig_409809',]
PHAGES = ['uvig_409809', 'uvig_430148', 'uvig_477575', 'uvig_560376']

#HOSTS = ['GCA_003436725']
HOSTS = ['GCA_003436725', 'GCA_003435635', 'GCA_003470775', 'GCF_000155205', 'GCA_003470035', 'GCA_003472405', 'GCA_003471505', 'GCA_003437995', 'GCA_003467905', 'GCA_003473205', 'GCA_003471045']

# Content from config:
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003436725.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003437995.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003467905.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003435635.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003470035.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003470775.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003471045.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003471505.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003472405.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCA_003473205.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/GCF_000155205.fna
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/ivig_3504.fa
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/uvig_409809.fa
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/uvig_430148.fa
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/uvig_477575.fa
##    - /home/hehouts/dynamic-duos-virome/phage_affix/data/ref_genomes/uvig_560376.fa



CATLASES = ['SRR5962882']

#HOST_RANGES = {'uvig_409809' : ['GCA_003436725']}

HOST_RANGES = {
    'uvig_409809' : ['GCA_003436725', 'GCA_003435635', 'GCA_003470775', 'GCF_000155205'],
    'uvig_430148' : ['GCA_003470035'],
    'uvig_477575' : ['GCA_003472405', 'GCA_003471505', 'GCA_003437995', 'GCA_003467905', 'GCA_003473205'],
    'uvig_560376' : ['GCA_003471045']
    }


# ██████████ THAT PART ██████████
from sourmash import load_one_signature
import pandas as pd
import os


# ██████████ RULE ALL ██████████
rule all: 
    input:
#       █ █ █ get genomes █ █ █
#        expand("data/ref_genomes/{phage}.fa", phage = PHAGES),
#        expand("data/ref_genomes/{host}.fna", host = HOSTS),
#
#       █ █ █ query catlas █ █ █    
#        expand("sgc_queries/{catlas}_k31_r1_search_oh0/{phage}.fa.cdbg_ids.reads.gz", phage = PHAGES, catlas = CATLASES),
#        expand("sgc_queries/{catlas}_k31_r1_search_oh0/{host}.fna.cdbg_ids.reads.gz", host = HOSTS, catlas = CATLASES),
#
#       █ █ █ sketch pN sigs █ █ █  
        expand("sigs/{phage}.{catlas}.fa.cdbg_ids.reads.sig",phage = PHAGES, catlas = CATLASES),
#       █ █ █ sketch hN sigs █ █ █  
        expand("sigs/{host}.{catlas}.fna.cdbg_ids.reads.sig", host = HOSTS, catlas = CATLASES),
#
#       █ █ █ sketch pRef █ █ █  
        expand("sigs/{phage}.fa.sig", phage = PHAGES),
#
#       █ █ █ sketch hRef █ █ █  
        expand("sigs/{host}.fna.sig",  host  = HOSTS),
#       █ █ █ write duos table █ █ █  
        "duos.csv",
#       █ █ █  █ █ █  
#
#       █ █ █  █ █ █  
#
#       █ █ █  █ █ █  
#
#       █ █ █  █ █ █  
#


# ██████████ GET PHAGE GENOMES ██████████
rule get_pRef_genomes:
    input:
        gutphagedatabase = "/group/ctbrowngrp/virus-references/gut-phage-db/GPD_sequences.fa.gz"

    output: 
        "data/ref_genomes/{phage}.fa"

    shell:"""
        zgrep -A1 '{wildcards.phage}' {input.gutphagedatabase} > {output}
        """

# ██████████ GET HOST GENOMES ██████████

rule get_hRef_genomes:
    output: 
        "data/ref_genomes/{host}.fna"

    shell:"""
        mkdir -p data/{wildcards.host}/

        datasets download genome accession {wildcards.host}.1 \
        --filename data/{wildcards.host}/{wildcards.host}.zip \
        --exclude-genomic-cds --exclude-gff3 --exclude-protein --exclude-rna 

        unzip data/{wildcards.host}/{wildcards.host}.zip -d data/{wildcards.host}/

        mv data/{wildcards.host}/ncbi_dataset/data/{wildcards.host}*/*.fna data/ref_genomes/{wildcards.host}.fna

        rm -rf data/{wildcards.host}/
        """

    
# ██████████ MAKE QUERY CONFIG ██████████
# could eventually automate actual config, by stealing from 'rule create_sgc_conf_wc' at: https://github.com/dib-lab/genome-grist/blob/d8ef5ef9ade8d25318ee08b51865bab5dd6c2c9e/genome_grist/conf/Snakefile
# but barf, so just confirm it exists?


# ██████████ QUERY METAGENOME ██████████

rule query_metagenome:
    input:
        expand("data/ref_genomes/{phage}.fa", phage = PHAGES),
        expand("data/ref_genomes/{host}.fna", host = HOSTS),
#        "sgc_queries/config.yml" 
#       if you make config a dependency, you cant touch it :D

    output:
        expand("sgc_queries/{catlas}_k31_r1_search_oh0/{phage}.fa.cdbg_ids.reads.gz", phage = PHAGES, catlas = CATLASES),
        expand("sgc_queries/{catlas}_k31_r1_search_oh0/{host}.fna.cdbg_ids.reads.gz", host = HOSTS, catlas = CATLASES)  
        
    shell:"""
        cd sgc_queries/
        python -m spacegraphcats run config.yml extract_contigs extract_reads --nolock
        cd ..
        """


# ██████████ SKETCH PHAGE NEIGHBORHOOD SIGS ██████████
rule sketch_pN_sigs:
    input:
        "sgc_queries/{catlas}_k31_r1_search_oh0/{phage}.fa.cdbg_ids.reads.gz"

    output:
        "sigs/{phage}.{catlas}.fa.cdbg_ids.reads.sig"
        
    shell:"""
        sourmash sketch dna -p k=21,scaled=1 {input} -o {output} 
        """

# ██████████ SKETCH HOST NEIGHBORHOOD SIGS ██████████
rule sketch_hN_sigs:
    input:
        "sgc_queries/{catlas}_k31_r1_search_oh0/{host}.fna.cdbg_ids.reads.gz"

    output:
        "sigs/{host}.{catlas}.fna.cdbg_ids.reads.sig"  
        
    shell:"""
        sourmash sketch dna -p k=21,scaled=1 {input} -o {output}
        """

# ██████████ SKETCH PHAGE REFERENCE GENOME SIGS ██████████


rule sketch_pRef_sigs:
    input:
        "data/ref_genomes/{phage}.fa" 

    output:
        "sigs/{phage}.fa.sig"
        
    shell:"""
        sourmash sketch dna -p k=21,scaled=1 {input} -o {output}
        """

# ██████████ SKETCH HOST REFERENCE GENOME SIGS ██████████

rule sketch_hRef_sigs:
    input:
        "data/ref_genomes/{host}.fna" 

    output:
        "sigs/{host}.fna.sig"
        
    shell:"""
        sourmash sketch dna -p k=21,scaled=1 {input} -o {output}
        """


# ██████████ MAKE SIG COMPARISONS (GENERATE PY DICTS?) ██████████

rule write_duos_table:
    input: 
        expand("sigs/{phage}.fa.sig", phage = PHAGES),
        expand("sigs/{host}.fna.sig",  host  = HOSTS),
        expand("sigs/{phage}.{catlas}.fa.cdbg_ids.reads.sig",phage = PHAGES, catlas = CATLASES),
        expand("sigs/{host}.{catlas}.fna.cdbg_ids.reads.sig", host = HOSTS, catlas = CATLASES),
    output:
        "duos.csv"

    run:
        duos_list = [] 
#
        for p in HOST_RANGES:
##### PHAGE REF
            p_ref_file = 'sigs/'+ p +'.fa.sig'
            pr_sig = load_one_signature(p_ref_file, ksize=21, select_moltype='DNA')
            pr_hash_set = set(pr_sig.minhash.hashes.keys())
            pr_hshs = len(pr_hash_set)
#
###### PHAGE NBHD
#            p_n_file = 'sigs/'+ p + '.' + wildcards.catlas + '.fa.cdbg_ids.reads.sig'
            p_n_file = 'sigs/'+ p + '.SRR5962882.fa.cdbg_ids.reads.sig'
            pn_sig = load_one_signature(p_n_file, ksize=21, select_moltype='DNA')
            pn_hash_set = set(pn_sig.minhash.hashes.keys())
            pn_hshs = len(pn_hash_set)
#
###### HOST REF
            host_list = (HOST_RANGES[p])
#
#
            for h in host_list:
                h_ref = h  
                h_ref_file = 'sigs/'+ h +'.fna.sig'
                hr_sig = load_one_signature(h_ref_file, ksize=21, select_moltype='DNA')
                hr_hash_set = set(hr_sig.minhash.hashes.keys())
                hr_hshs = len(hr_hash_set)
#
#
####### HOST NBHD
#                h_n_file = 'sigs/'+ h + '.' + wildcards.catlas + '.fna.cdbg_ids.reads.sig'
                h_n_file = 'sigs/'+ h + '.SRR5962882.fna.cdbg_ids.reads.sig'
                hn_sig = load_one_signature(h_n_file, ksize=21, select_moltype='DNA')
                hn_hash_set = set(hn_sig.minhash.hashes.keys())
                hn_hshs = len(hn_hash_set)
#
#
                cmt_pr_in_hr = pr_sig.contained_by(hr_sig)
                cmt_hr_in_pr = hr_sig.contained_by(pr_sig) 
                pr_hr_sh_hshs = len(pr_hash_set & hr_hash_set)
                hr_pr_sh_hshs = pr_hr_sh_hshs
#
                cmt_pn_in_hn = pn_sig.contained_by(hn_sig)
                cmt_hn_in_pn = hn_sig.contained_by(pn_sig)
                pn_hn_sh_hshs = len(pn_hash_set & hn_hash_set)
                hn_pn_sh_hshs = pn_hn_sh_hshs
#
                cmt_pr_in_pn = pr_sig.contained_by(pn_sig)
                cmt_pn_in_pr = pn_sig.contained_by(pr_sig)
                pr_pn_sh_hshs = len(pr_hash_set & pn_hash_set)
                pn_pr_sh_hshs = pr_pn_sh_hshs
#
                cmt_hr_in_hn = hr_sig.contained_by(hn_sig)
                cmt_hn_in_hr = hn_sig.contained_by(hr_sig)
                hn_hr_sh_hshs = len(hn_hash_set & hr_hash_set)
                hr_hn_sh_hshs = hn_hr_sh_hshs
#
                cmt_pn_in_hr = pn_sig.contained_by(hr_sig)
                cmt_hr_in_pn = hr_sig.contained_by(pn_sig)
                pn_hr_sh_hshs = len(pn_hash_set & hr_hash_set)
                hr_pn_sh_hshs = pn_hr_sh_hshs
#
                cmt_pr_in_hn = pr_sig.contained_by(hn_sig)
                cmt_hn_in_pr = hn_sig.contained_by(pr_sig)
                pr_hn_sh_hshs = len(pr_hash_set & hn_hash_set)
                hn_pr_sh_hshs = pr_hn_sh_hshs
#
#
                duo = { 
#                        'mgx_id': wildcards.catlas,
                        'mgx_id': 'SRR5962882',
                        'pr':     p ,
                        'hr':     h ,
#
                        'pr_hshs': pr_hshs ,
                        'hr_hshs': hr_hshs ,
                        'pn_hshs': pn_hshs   ,
                        'hn_hshs': hn_hshs   ,
#
                        'cmt_pr_in_hr': cmt_pr_in_hr ,
                        'cmt_hr_in_pr': cmt_hr_in_pr ,
                        'pr_hr_sh_hshs': pr_hr_sh_hshs ,
#
                        'cmt_pn_in_hn': cmt_pn_in_hn ,
                        'cmt_hn_in_pn': cmt_hn_in_pn ,
                        'pn_hn_sh_hshs': pn_hn_sh_hshs ,
#
                        'cmt_pr_in_pn': cmt_pr_in_pn ,
                        'cmt_pn_in_pr': cmt_pn_in_pr ,
                        'pr_pn_sh_hshs': pr_pn_sh_hshs ,
#
                        'cmt_hr_in_hn': cmt_hr_in_hn ,
                        'cmt_hn_in_hr': cmt_hn_in_hr ,
                        'hr_hn_sh_hshs': hr_hn_sh_hshs ,
#
                        'cmt_pn_in_hr': cmt_pn_in_hr ,
                        'cmt_hr_in_pn': cmt_hr_in_pn ,
                        'pn_hr_sh_hshs': pn_hr_sh_hshs ,
#
                        'cmt_pr_in_hn': cmt_pr_in_hn,
                        'cmt_hn_in_pr': cmt_hn_in_pr,
                        'pr_hn_sh_hshs':  pr_hn_sh_hshs, 
                    }
                duos_list.append(duo)
            duos_df = pd.DataFrame.from_records(duos_list)
            duos_df.to_csv(os.getcwd()+'/duos.csv', sep = ',', index=False) 





##### cheap, dirty cheater rules

# rule cheat:
#     input:
#     expand("sigs/{host}.{catlas}.fna.cdbg_ids.reads.sig", host = HOSTS, catlas = CATLASES)
#     expand("sgc_queries/{catlas}_k31_r1_search_oh0/{host}.fna.cdbg_ids.reads.gz", host = HOSTS, catlas = CATLASES),
#     output:
#         'chuck.txt'
#     shell:"""
#     touch {output}
#     """

####### pick n pull #################################################################################
# input:
# for key in HOST_RANGES:
#     print('sigs/'+ key +'.fa.sig')



# WORKS:

# for p in HOST_RANGES:
#     print(p)
#     print(HOST_RANGES[p])



# WORKS:

# for key in HOST_RANGES:
#     print(key)
#     host_list = (HOST_RANGES[key])
# #    print(host_list)
#     for host in host_list:
#         print(host)




#     h_ref_file = 'GCA_900066145.1_genomic.fna.gz.sig'
#     h_ref_sig = load_one_signature(h_ref_file, ksize=21, select_moltype='DNA')


#     h_ref_file = 'GCA_900066145.1_genomic.fna.gz.sig'
# #    print(key, '->', HOST_RANGES[key])
#     for host in HOST_RANGES[key]
#         print(host)



