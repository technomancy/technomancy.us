LATEST=188
SRC := $(wildcard *.m4 | grep -v feed.m4)
OUTPUTS := $(patsubst %.m4,out/%.html,$(SRC))

all: $(OUTPUTS) out/atom.xml out/style.css out/i

out/%.html: %.m4 header.html footer.html ; m4 -D__latest=$(LATEST) $< > $@
out/atom.xml: feed.m4 ; m4 -D__latest=$(LATEST) $< > $@
out/style.css: static/*.css ; cat $^ > $@
out/i: static/i ; ln -s $(PWD)/static/i $@

prepublish: ; rm -f out/list.html out/index.html out/atom.xml out/feed.xml

clean: ; rm out/*

watch: ; echo $(SRC) | tr " " "\n" | entr make
server: all ; cd out; python -m SimpleHTTPServer 3001

upload: all; rsync -azPL out/ p:technomancy.us/new/
