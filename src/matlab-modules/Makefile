#
REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(NBCRDEVEL)/NBCR.mk

MODULEFILES = matlab.module matlab.version

ADDSED = \
	-e s%@MATLABDIR@%$(MATLABDIR)%g \
	-e s%@MCRVER@%$(MCRVER)%g 

%: %.in
	$(SED) $(SEDSCRIPT) $(ADDSED) $^ > $@

pretar:: $(VERSION.MK.INCLUDE)

$(VERSION.MK.INCLUDE): 
	if [ -f $(VERSION.MK.MASTER) ]; then \
		/bin/cp $(VERSION.MK.MASTER) $@; \
	fi

build: $(MODULEFILES)

install:: modulefile-install

clean::
	rm -rf $(NAME).spec.* 
	rm -rf $(VERSION.MK.INCLUDE)
	rm -rf $(MODULEFILES)
	rm -rf version.mk

