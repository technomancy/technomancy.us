upload: links.html outline.html index.html
	rsync -r $^ technomancy.us:technomancy.us/public/talks/fennel-nodemcu/

links.html: links.org; pandoc -o links.html links.org

outline.html: outline.md; pandoc -o outline.html outline.md
