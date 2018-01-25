SRC := $(wildcard *.m4)
OUTPUTS := $(patsubst %.m4,out/%.html,$(SRC))

all: $(OUTPUTS)

out/%.html : %.m4 header.html footer.html
	m4 $< > $@
	@grep __last $< > /dev/null && cp $@ out/index.html || true

# out/atom.xml: ; echo TODO: actually generate this

clean: ; rm out/*

server: all ; cd out; python -m SimpleHTTPServer 3001

upload: all
	rsync -azP out/ technomancy.us:technomancy.us/new
	rsync -azP static/ technomancy.us:technomancy.us/new/

# TODO: serve font locally with the rest
