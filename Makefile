version = 1.0-SNAPSHOT

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

all: clean install

install:
	mvn install

clean:
	mvn clean

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

