#!/bin/sh
wget -O- "https://mywaifulist.moe/random" | hxnormalize -x | hxextract -x "meta" - | hxselect -s '\n' -i "::attr(content)" | grep -E '(jpeg|png|jpg)' | head -1 | cut -d '"' -f2 | wget -O waifu.png -i-
nsxiv waifu.png
rm waifu.png

