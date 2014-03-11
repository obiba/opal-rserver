version = 1.0-SNAPSHOT

all: clean sign

clean:
	rm -rf build

package:
	mkdir -p build && \
	cd build && \
	cp ../ns-control . && \
	sed -i 's/@version@/$(version)/' ns-control && \
	equivs-build ns-control && \
	echo "" && \
	echo "Package opal-rserver_${version}_all.deb created in build directory" && \
	echo ""

sign: package
	debsigs --sign origin build/opal-rserver_${version}_all.deb
	echo "" && \
	echo "Signed package build/opal-rserver_${version}_all.deb" && \
	echo ""

