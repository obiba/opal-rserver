version = 1.0-SNAPSHOT

all: clean package

clean:
	rm -rf build

package:
	mkdir buid && \
	equivs-control ns-control && \
	mv *.deb build
