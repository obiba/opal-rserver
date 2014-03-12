opal-rserver
=============

Opal R server meta Debian package


## Create the package

Depends on equivs-build: `sudo apt-get install equivs-build`

```
make all [sign=true]
```

Package is built to `build/opal-rserver-<version>_all.deb`


## Publish signed package

```
make publish dir=<destination> sign=true
```
