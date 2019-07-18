# spacegraphcats-twofoo-example

This is an example
[spacegraphcats](https://github.com/spacegraphcats/spacegraphcats/)
project using some real data from
[Shakya et al., 2013](https://www.ncbi.nlm.nih.gov/pubmed/23387867), to
demonstrate a snakemake-based workflow for spacegraphcats queries.

See
[spacegraphcats/spacegraphcats-dory-example](https://github.com/spacegraphcats/spacegraphcats-dory-example)
for what the various output files contain.

## Quickstart:

You'll need Python 3.5 or greater. We suggest working in a
[conda](https://conda.io/docs/) environment; you can set this up in
conda like so:

```
conda create -n space python==3.6
conda activate space
```

Then execute:
```
conda install -y snakemake bcalm
pip install Cython
pip install https://github.com/dib-lab/pybbhash/archive/spacegraphcats.zip
pip install https://github.com/dib-lab/khmer/archive/master.zip
pip install git+https://github.com/dib-lab/sourmash@master#egg=sourmash

pip install spacegraphcats
```

and run

```
snakemake
```
to run the full spacegraphcats workflow.
