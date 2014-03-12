opal-rserver
=============

Opal R server meta Debian package


## Create the package

Depends on equivs-build: `sudo apt-get install equivs-build`

```
make all [sign=true]
```


## Publish signed package

```
make publish dir=<destination> sign=true
```
