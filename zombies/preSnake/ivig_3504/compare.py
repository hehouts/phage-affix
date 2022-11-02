# ██████████ 
import pandas as pd
import os
from sourmash import load_one_signature
#
# ██████████ 
#
PHAGES = ['uvig_409809']
HOSTS = ['GCA_003436725']
CATLASES = ['SRR5962882']
HOST_RANGES = {'uvig_409809' : ['GCA_003436725']}
# ██████████ 
#
duos_list = []
duos_df = 'init/reset' 
#
for p in HOST_RANGES:
##### PHAGE REF
    p_ref_file = 'sigs/'+ p +'.fa.sig'
    pr_sig = load_one_signature(p_ref_file, ksize=21, select_moltype='DNA')
    pr_hash_set = set(pr_sig.minhash.hashes.keys())
    pr_hshs = len(pr_hash_set)
#
###### PHAGE NBHD
#    p_n_file = 'sigs/'+ p + '.' + wildcards.catlas + '.fa.cdbg_ids.reads.sig'
    p_n_file = 'sigs/'+ p + '.' + CATLASES[0] + '.fa.cdbg_ids.reads.sig'
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
#        h_n_file = 'sigs/'+ h + '.' + wildcards.catlas + '.fna.cdbg_ids.reads.sig'
        h_n_file = 'sigs/'+ h + '.' + CATLASES[0] + '.fna.cdbg_ids.reads.sig'
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
        pn_hr_sh_hshs = len(pn_hash_set & pr_hash_set)
        hr_pn_sh_hshs = pn_hr_sh_hshs
#
        cmt_pr_in_hn = pr_sig.contained_by(hn_sig)
        cmt_hn_in_pr = hn_sig.contained_by(pr_sig)
        pr_hn_sh_hshs = len(pr_hash_set & hn_hash_set)
        hn_pr_sh_hshs = pr_hn_sh_hshs
#
#
        duo = {
                'mgx_id:CATLAS[0]' 
#                'mgx_id': wildcards.catlas,
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







# pandas cheatcodes: https://www.geeksforgeeks.org/how-to-add-one-row-in-an-existing-pandas-dataframe/

