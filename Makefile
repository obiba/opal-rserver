version = 1.0-SNAPSHOT
package = opal-rserver_${version}

all: clean sign

clean:
	rm -rf build

package:
	mkdir -p build/${package}/DEBIAN && \
	cp debian/* build/${package}/DEBIAN && \
	cd build && \
	sed -i 's/@version@/$(version)/' ${package}/DEBIAN/control && \
	fakeroot dpkg --build ${package} && \
	echo "" && \
	echo "Package ${package}.deb created in build directory" && \
	echo ""

sign: package
	debsigs --sign origin build/${package}.deb && \
	echo "" && \
	echo "Signed package build/${package}.deb" && \
	echo ""

publish: sign
	cp build/${package}.deb ${dir}
