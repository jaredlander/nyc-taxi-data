# cat setup_files/just_yellow_urls.txt | xargs -n 1 -P 6 wget -c -P data/
cat setup_files/yellow2015urls.txt | xargs -n 1 -P 6 wget -c -P data/
