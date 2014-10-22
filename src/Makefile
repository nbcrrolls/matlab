# $Id: $
#
# @Copyright@
# @Copyright@
#
# $Log:  $
#

-include $(shell $(ROCKSROOT)/bin/arch).mk
-include $(shell $(ROCKSROOT)/bin/os).mk

SRCDIRS = `find . -maxdepth 1 -type d -not -name CVS -not -name .svn -not -name .`
SRCDIRS = rocks-matlab

default: rpm

copyright pkg rpm clean::
	for i in $(SRCDIRS) ; do \
		(cd $$i; $(MAKE) $@) ; \
	done
