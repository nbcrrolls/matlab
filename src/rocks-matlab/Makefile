# @Copyright@
# @Copyright@

PKGROOT      = /share/apps/matlab

REDHAT.ROOT = $(CURDIR)/../../
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk


SEDMAT = \
        -e 's%@MATLAB_HOME@%$(PKGROOT)%g' \
        -e 's%@MCR@%$(MCR)%g' \
        -e 's%@MATLAB_VERSION@%$(MATLAB_VERSION)%g' 

version.mk: version.mk.in
	cat version.mk.in ../version.mk > version.mk

matlab.sh: matlab.sh.in
	$(SED) $(SEDMAT) $^ > $@

matlab.csh: matlab.csh.in
	$(SED) $(SEDMAT) $^ > $@

build: matlab.sh matlab.csh

install::
	mkdir -p $(ROOT)/etc/profile.d
	$(INSTALL) -m755  matlab.*sh  $(ROOT)/etc/profile.d

clean::
	rm -f version.mk matlab.sh matlab.csh

