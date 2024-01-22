# bin/bash

rm -rf ./data/wrd-legacy
wget https://github.com/acdh-oeaw/digitarium-data/archive/refs/heads/master.zip
unzip master
mkdir ./data/wrd-legacy
mv digitarium-data-master/*/*/*/*.xml ./data/wrd-legacy
rm -rf digitarium-data-master
rm master.zip
