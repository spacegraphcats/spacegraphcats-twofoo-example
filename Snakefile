import sys
from spacegraphcats.snakemake import (catlas_build, catlas_search,
                                      catlas_extract, catlas_search_input)

sgc_config_file = 'config.yaml'

rule all:
    input:
        catlas_search(sgc_config_file),
        catlas_extract(sgc_config_file)

rule clean:
    shell:
        "python -m spacegraphcats run {sgc_config_file} clean"

rule build:
    input:
        "data/twofoo.fq.gz"
    output:
        catlas_build(sgc_config_file)
    shell:
        "python -m spacegraphcats run {sgc_config_file} build --nolock"

rule search:
    input:
        catlas_search_input(sgc_config_file),
        catlas_build(sgc_config_file),
    output:
        catlas_search(sgc_config_file)
    shell:
        "python -m spacegraphcats run {sgc_config_file} search --nolock"

rule extract:
    input:
        catlas_search(sgc_config_file),
    output:
        catlas_extract(sgc_config_file)
    shell:
        "python -m spacegraphcats run {sgc_config_file} extract_reads extract_contigs --nolock"


#
# akker-reads.abundtrim.gz is a collection of reads from podar data
# that maps to the Akkermansia muciniphila ATCC BAA-835 genome via bwa aln.
# "Real" data, with known answer.  There does not appear to be significant
# overlap with other genomes in the Podar data set; so, no significant strain
# variation.
#

rule download_akker:
    output:
        "data/akker-reads.abundtrim.gz"
    shell:
    	"curl -o {output} -L https://osf.io/dk7nb/download"

#
# shew-reads.abundtrim.gz is a collection of reads from podar data
# that maps to the Shewanella OS223 genome via bwa aln.  "Real" data,
# with known answer.  Note that there is significant overlap with the
# Shewanella OS185 genome; this is a data set with significant strain
# variation.
#

rule download_shew:
    output:
        "data/shew-reads.abundtrim.gz"
    shell:
    	"curl -o {output} -L 'https://osf.io/7az9p/?action=download'"

#
# twofoo, use a synthetic mixture of reads from podar data -
# the shew-reads.abundtrim.gz (mapping to Shewanella baltica OS223) and
# akker-reads.abundtrim.gz (mapping to Akkermansia muciniphila ATCC BAA-835).
# Many of the shew-reads also map to S. baltica OS185, while the akker-reads
# do not; so this is a good mixture for testing the effects of strain variation
# on catlas foo.

rule make_twofoo:
    input:
        "data/shew-reads.abundtrim.gz",
        "data/akker-reads.abundtrim.gz"
    output:
        "data/twofoo.fq.gz"
    shell:
        "gunzip -c {input} | gzip -9c > {output}"
