opal-rserver
=============

Opal R server meta Debian package


## Create and sign the package

Depends on debsigs: `sudo apt-get install debsigs`

```
make all
```

## Publish package

```
make publish dir=<destination>
```
