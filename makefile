all: gen-build run-build

gen-build:
	mkdir -p bin
	ghc --make ExampleBuild.hs -rtsopts -with-rtsopts=-I0 -outputdir=bin -o bin/build

run-build:
	cd docs && ../bin/build

auto:
	gulp watch

clean:
	cd docs && ../bin/build clean
	rm -rf bin

.PHONY: clean
