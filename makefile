all: auto-reload-html

auto-reload-html:
	mkdir -p build
	mkdir -p bin
	ghc --make AutoReloadHtml.hs -rtsopts -with-rtsopts=-I0 -outputdir=build -o bin/auto-reload-html

clean:
	rm -rf build
	rm -rf bin

.PHONY: clean
