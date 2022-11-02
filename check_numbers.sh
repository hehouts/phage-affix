from sourmash import load_one_signature
import pandas as pd

uvig_477575
GCA_003472405
GCA_003471505
GCA_003437995
GCA_003467905
GCA_003473205


p_ref_file = 'sigs/'+ p +'.fa.sig'
pr_sig = load_one_signature(p_ref_file, ksize=21, select_moltype='DNA')
pr_hash_set = set(pr_sig.minhash.hashes.keys())
pr_hshs = len(pr_hash_set)

cmt_pn_in_hr = pn_sig.contained_by(hr_sig)
cmt_hr_in_pn = hr_sig.contained_by(pn_sig)
pn_hr_sh_hshs = len(pn_hash_set & pr_hash_set)
#hr_pn_sh_hshs = pn_hr_sh_hshs