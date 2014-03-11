version = 1.0-SNAPSHOT

all: clean package

clean:
	rm -rf build

package:
	mkdir -p build && \
	equivs-build ns-control && \
	mv *.deb build
