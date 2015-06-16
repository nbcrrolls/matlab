#!/bin/bash

SCRDIR=src/matlab
echo "NOTE: must have valid  FileInstallationKey.txt file in $SCRDIR"
echo "NOTE: must have valid  license.dat file in $SCRDIR"

DATA=`grep ^DATA $SCRDIR/version.mk.in | awk '{print $3}'`
echo "NOTE: put matlab ISO distro and mcr zip distro in $DATA (DATA is defined in $SCRDIR/version.mk.in)"

(cd src/matlab; make prep-rpm)
