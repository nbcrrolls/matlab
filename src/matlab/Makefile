#
# @Copyright@
# @Copyright@
#

PKGROOT = /share/apps/$(NAME)/$(VERSION)
DISTRO = $(NAME)-$(VERSION)
MCRDISTRO = $(MCR)_$(VERSION)_glnxa64_installer.zip
KEY=$(shell cat FileInstallationKey.txt)

REDHAT.ROOT = $(PWD)/../../
-include $(ROCKSROOT)/etc/Rules.mk


SEDSPEC += \
        -e 's%PKGROOT%$(PKGROOT)%g' \
        -e 's%ROLLPATH%$(PWD)/$(DISTRO)%g' \
        -e "s%KEY%$(KEY)%g" \

installer_input: installer_input.in
	$(SED) $(SEDSPEC) $^ > $@

pre-build: installer_input
	# build matlab distro
	cat $(NAME)-$(VERSION).* | tar zxvf -
	cp installer_input  $(NAME)-$(VERSION)/
	cp License.lic $(NAME)-$(VERSION)/license.dat
	( \
	    cd $(DISTRO)/bin/glnxa64; \
	    rm libstdc++.so.6* ;  \
	    cp /usr/lib64/libstdc++.so.6.* .; \
	    ln -s libstdc++.so.6.* libstdc++.so.6; \
        )
	mkdir -p  $(PKGROOT)
	( \
	    cd $(DISTRO); \
	    ./install  -inputFile installer_input ; \
        )
	# build matlab MCR distro
	unzip $(MCRDISTRO)
	cp installer_input $(MCR)/
	( \
	    cd $(MCR); \
	    ./install  -inputFile installer_input ; \
        )

prep-rpm:: pre-build
	rocks create package $(PKGROOT)/toolbox/compiler $(NAME)-$(VERSION)-toolbox-compiler
	rm -rf $(PKGROOT)/toolbox/compiler/
	rocks create package $(PKGROOT)/toolbox/vision $(NAME)-$(VERSION)-toolbox-vision
	rm -rf $(PKGROOT)/toolbox/vision
	rocks create package $(PKGROOT)/toolbox $(NAME)-$(VERSION)-toolbox
	rm -rf $(PKGROOT)/toolbox/
	rocks create package $(PKGROOT)/$(MCRVER) $(NAME)-$(VERSION)-mcr
	rm -rf $(PKGROOT)/$(MCRVER)/
	rocks create package $(PKGROOT) $(NAME)-$(VERSION)
	rm -rf $(PKGROOT)
	# the /root/data/$(NAME)-$(VERSION)/ must have enough space ~2.5Gb
	mkdir -p /root/data/$(NAME)-$(VERSION)/
	-cp *.$(ARCH).rpm $(DATA)/$(NAME)/$(VERSION)/
	-cp License.lic $(DATA)/$(NAME)/license.dat

install::

clean::
	rm -rf installer_input
