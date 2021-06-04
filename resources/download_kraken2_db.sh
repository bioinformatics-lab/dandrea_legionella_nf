#!/usr/bin/env bash
set -euo pipefail

# /*
# Taken from BACTpipe - https://github.com/ctmrbio/BACTpipe v3.1
# */


# Convenience script to download a Kraken2 database for use with BACTpipe
# https://bactpipe.readthedocs.org


wget -r 'ftp://ftp.ccb.jhu.edu/pub/data/kraken2_dbs/old/minikraken2_v2_8GB_201904.tgz'

echo "Kraken2 database downloaded!"
echo "Please extract to a folder of your choice, e.g.:"
echo "  tar -xf minikraken2_v2_8GB_201904.tgz /path/to/folder"
