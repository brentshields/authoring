all: gen-build run-build

gen-build:
	mkdir -p bin
	ghc --make AutoReloadHtml.hs -rtsopts -with-rtsopts=-I0 -outputdir=bin -o bin/build

run-build:
	bin/build

auto:
	gulp watch

clean:
	bin/build clean
	rm -rf bin

.PHONY: clean
