from sourmash import load_one_signature

p_ref_file = 'sigs/ivig_358.k21.fa.sig'
p_ref_sig = load_one_signature(p_ref_file, ksize=21, select_moltype='DNA')
p_ref_hashset = set(p_ref_sig.minhash.hashes.keys())

metagenome_file = 'grist/outputs.gather_virome/sigs/SM_CTTKX.trim.sig'
metagenome_sig = load_one_signature(metagenome_file, ksize=21, select_moltype='DNA')
metagenome_hashset = set(metagenome_sig.minhash.hashes.keys())

hits_hashset = p_ref_hashset & metagenome_hashset



len(p_ref_hashset)
len(metagenome_hashset)
len(hits_hashset)

len(p_ref_hashset & hits_hashset)


len(p_ref_hashset & p_nbhd_hashset)

#p_ref_file = 'sigs/' + p + '_k' + str(k) + '_r' + str(r) + '.fa.sig'
#p_ref_sig = load_one_signature(p_ref_file, ksize=k, select_moltype='DNA')
#p_ref_hashset = set(p_ref_sig.minhash.hashes.keys())