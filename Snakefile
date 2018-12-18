from spacegraphcats.snakemake import (catlas_build, catlas_search,
                                      catlas_extract)

rule all:
    input:
        "data/twofoo.fq.gz",
        catlas_build('config.yaml')

rule build:
    input:
        "data/twofoo.fq.gz"
    output:
        catlas_build('config.yaml')
    shell:
        "spacegraphcats build config.yaml"

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
        "gunzip -c {input} | gzip -9c > twofoo.fq.gz"
