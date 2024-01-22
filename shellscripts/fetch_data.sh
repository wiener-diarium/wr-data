# bin/bash

rm -rf ./data/wrd-present
rm -rf ./data/pre-process
rm -rf ./data/facs
wget https://github.com/wiener-diarium/wr-transkribus-out/archive/refs/heads/main.zip
unzip main
mkdir ./data
mkdir ./data/pre-process
mkdir ./data/wrd-present
mkdir ./data/facs
mv wr-transkribus-out-main/tei/*.xml ./data/pre-process
mv wr-transkribus-out-main/mets/209792/*.xml ./data/facs
rm -rf wr-transkribus-out-main
rm main.zip
