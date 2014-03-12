version = 1.0-SNAPSHOT
package = opal-rserver_${version}
date = $(shell date -R)

all: clean sign

clean:
	rm -rf build

package:
	mkdir -p build/${package}/ && \
	cp -r debian build/${package} && \
	cd build/${package} && \
	sed -i 's/@version@/$(version)/' debian/changelog && \
	sed -i 's/@version@/$(version)/' debian/control && \
	sed -i 's/@date@/$(date)/' debian/changelog && \
	fakeroot dpkg-buildpackage && \
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
