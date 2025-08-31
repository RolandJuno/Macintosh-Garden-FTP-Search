#!/bin/bash

echo "Updating Macintosh Garden FTP directory listings."

# Fetch new listings
curl ftp://repo1.macintoshgarden.org/Garden/apps/    --user macgarden:publicdl > garden-apps.txt
curl ftp://repo1.macintoshgarden.org/Garden/games/   --user macgarden:publicdl > garden-games.txt
curl ftp://repo1.macintoshgarden.org/Garden/manuals/ --user macgarden:publicdl > garden-manuals.txt

# Remove .MD5 entries
grep -v .md5 garden-apps.txt    > garden-apps2.txt
grep -v .md5 garden-games.txt   > garden-games2.txt
grep -v .md5 garden-manuals.txt > garden-manuals2.txt

# Remove first 60 chars of FTP directory listing from each line
cat garden-apps2.txt| cut -c 60- > garden-apps3.txt
cat garden-games2.txt| cut -c 60- > garden-games3.txt
cat garden-manuals2.txt| cut -c 60- > garden-manuals.txt

# Remove old listing
rm garden.txt
touch garden.txt

# Add prefixes
sed -e 's/^/\/Garden\/apps\//'    garden-apps3.txt    >>garden.txt
sed -e 's/^/\/Garden\/games\//'   garden-games3.txt   >>garden.txt
sed -e 's/^/\/Garden\/manuals\//' garden-manuals3.txt >>garden.txt

# Clean up
rm garden-apps.txt garden-apps2.txt garden-apps3.txt
rm garden-games.txt garden-games2.txt garden-games3.txt
rm garden-manuals.txt garden-manuals2.txt garden-manuals3.txt

echo "Done."
