version = 1.0-SNAPSHOT
package = opal-rserver_${version}
date = $(shell date -R)

ifeq (${sign},true)
	build_options=--full
else
	build_options=
endif

all: clean package check

clean:
	rm -rf build

package:
	mkdir -p build/${package}/ && \
	cp -r debian/* build/${package} && \
	cd build/${package} && \
	sed -i 's/@version@/$(version)/' changelog && \
	sed -i 's/@version@/$(version)/' ns-control && \
	sed -i 's/@date@/$(date)/' changelog && \
	equivs-build ${build_options} ns-control && \
	mv ${package}_all.deb ..
	echo "" && \
	echo "Package ${package}_all.deb created in build directory" && \
	echo ""

publish: package check
	echo "Publish package"
	cp build/${package}_all.deb ${dir}

check:
  echo "Validate package"
	lintian build/${package}_all.deb