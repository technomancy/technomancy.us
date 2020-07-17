upload: links.txt outline.html index.html
	rsync -r $^ technomancy.us:technomancy.us/public/talks/fediverse/

outline.html: outline.md; pandoc -o outline.html outline.md

links.txt: outline.md ; grep http $^ > $@

open: links.txt
	cat links.txt | tr "\n" " " | xargs firefox
