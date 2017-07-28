# Script for collecting the catalog of various imageboards
# Thanks /inta/ anon
curl https://domain/board/catalog.html | grep -Eo "/board/res/.{0,5}.html" | cut -d / -f 4 | cut -d . -f 1 > test.txt

