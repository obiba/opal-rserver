#!/bin/sh
# postinst script for rserver
#

set -e

case "$1" in
    [1-2])

      Rscript -e "install.packages(c('opal', 'opalr', 'tidyverse', 'knitr', 'rmarkdown'), repos=c('https://cloud.r-project.org', 'https://cran.obiba.org'), dependencies=TRUE, lib='/usr/share/R/library')"

      Rscript -e "if (R.Version()\$major >= 3) { install.packages('opaladdons', repos=c('https://cloud.r-project.org', 'https://cran.obiba.org'), dependencies=TRUE, lib='/usr/share/R/library') }"

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
