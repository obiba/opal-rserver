#!/bin/sh
# postinst script for rserver
#

set -e

case "$1" in
    1)

      Rscript -e "install.packages(c('opal', 'ggplot2', 'haven', 'rmarkdown'), repos=c('http://cran.rstudio.com', 'http://cran.obiba.org'), dependencies=TRUE, lib='/usr/local/lib/R/site-library')"

      Rscript -e "if (R.Version()\$major >= 3) { install.packages('opaladdons', repos=c('http://cran.rstudio.com', 'http://cran.obiba.org'), dependencies=TRUE, lib='/usr/local/lib/R/site-library') }"

    ;;

    abort-upgrade|abort-remove|abort-deconfigure)
    ;;

    *)
        echo "postinst called with unknown argument \`$1'" >&2
        exit 1
    ;;
esac

#DEBHELPER#

exit 0
