version = 1.0-SNAPSHOT
package = opal-rserver_${version}
package_rpm = opal-rserver-${version}
date = $(shell date -R)

ifeq ($(findstring SNAPSHOT,$(version)),SNAPSHOT)
	stability=unstable
else
	stability=stable
endif

ifeq (${sign},true)
	build_options=--full
else
	build_options=
endif

all: clean package check

clean:
	rm -rf build && \
	mvn clean

package: package-deb package-rpm

package-deb:
	mkdir -p build/${package}/ && \
	cp -r src/dist/debian/* build/${package} && \
	cd build/${package} && \
	sed -i 's/@version@/$(version)/' changelog && \
	sed -i 's/@version@/$(version)/' ns-control && \
	sed -i 's/@date@/$(date)/' changelog && \
	equivs-build ${build_options} ns-control && \
	mv ${package}_all.deb ..
	echo "" && \
	echo "Package ${package}_all.deb created in build directory" && \
	echo ""

package-rpm:
	mvn clean install -Pci-build


publish: publish-deb publish-rpm

publish-deb: package-deb check
	@echo "Publish package Debian" && \
	cp build/${package}_all.deb ${dir}/${stability}

publish-rpm: package-rpm
	@echo "Publish package RPM" && \
	cp target/rpm/opal-rserver/RPMS/noarch/${package_rpm}*.rpm ${dir_rpm}/${stability}

check:
	@echo "Validate package"
	lintian build/${package}_all.deb

release:
ifeq (${releaseVersion},)
	$(error releaseVersion cannot be null.)
endif
ifeq (${nextVersion},)
	$(error nextVersion cannot be null.)
endif
	@echo "Release ${releaseVersion} version (next version: ${nextVersion})"
	sed -i 's/^version = .*$$/version = ${releaseVersion}/' Makefile && \
	git commit -a -m "Prepare release ${releaseVersion}" && \
	git tag ${releaseVersion}
	sed -i 's/^version = .*$$/version = ${nextVersion}/' Makefile && \
	git commit -a -m "Set new development version to ${nextVersion}" && \
	git push origin master --tags

