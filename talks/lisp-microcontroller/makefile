upload: links.html outline.html index.html
	rsync -r $^ technomancy.us:technomancy.us/public/talks/lisp-microcontroller/

outline.html: outline.md; pandoc -o outline.html outline.md

links.txt: outline.md ; grep http $^ > $@
links.html: links.txt ; pandoc -f markdown -o $@ $<
slides.md: links.txt ; fennel screenshots.fnl $^ $@
slides.pdf: slides.md ; pandoc -V geometry:landscape -o $@ $<

clean: ; rm -rf links.txt screenshots/* slides.pdf outline.html
