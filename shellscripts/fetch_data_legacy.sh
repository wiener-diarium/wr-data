# bin/bash

rm -rf ./data/wrd-legacy && mkdir ./data/wrd-legacy
rm -rf ./data/pre-process-l && mkdir ./data/pre-process-l
wget https://github.com/acdh-oeaw/digitarium-data/archive/refs/heads/master.zip
unzip master
mv digitarium-data-master/*/*/*/*.xml ./data/pre-process-l
rm -rf digitarium-data-master
rm master.zip
