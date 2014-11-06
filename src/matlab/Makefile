#
# @Copyright@
# @Copyright@
#

PKGROOT = /share/apps/$(NAME)/$(VERSION)
DISTRO = $(NAME)-$(VERSION)
MCRDISTRO = $(MCR)_R$(VERSION)_glnxa64_installer.zip
KEY=$(shell cat FileInstallationKey.txt)

REDHAT.ROOT = $(PWD)/../../
-include $(ROCKSROOT)/etc/Rules.mk


SEDSPEC += \
        -e 's%PKGROOT%$(PKGROOT)%g' \
        -e 's%ROLLPATH%$(PWD)%g' \
        -e "s%KEY%$(KEY)%g" \

version.mk: version.mk.in
	cat ../../matlab.mk version.mk.in > version.mk

installer_input: installer_input.in
	$(SED) $(SEDSPEC) $^ > $@

pre-build: version.mk installer_input
	# build matlab distro
	cp installer_input  $(NAME)-$(VERSION)/
	mkdir -p  $(PKGROOT)
	( \
	    cd $(DISTRO); \
	    ./install  -inputFile installer_input ; \
        )

mcr: version.mk installer_input
	# build matlab MCR distro
	mkdir $(MCR)
	(cd $(MCR); unzip ../$(MCRDISTRO))
	cp installer_input $(MCR)/
	( \
	    cd $(MCR); \
	    ./install  -inputFile installer_input ; \
        )

prep-rpm:: version.mk pre-build mcr

	rocks create package $(PKGROOT)/toolbox/compiler $(NAME)-$(VERSION)-toolbox-compiler
	rm -rf $(PKGROOT)/toolbox/compiler/

	rocks create package $(PKGROOT)/toolbox/vision $(NAME)-$(VERSION)-toolbox-vision
	rm -rf $(PKGROOT)/toolbox/vision

	rocks create package $(PKGROOT)/toolbox/images $(NAME)-$(VERSION)-toolbox-images
	rm -rf $(PKGROOT)/toolbox/images

	rocks create package $(PKGROOT)/toolbox/comm $(NAME)-$(VERSION)-toolbox-comm
	rm -rf $(PKGROOT)/toolbox/comm

	rocks create package $(PKGROOT)/toolbox/bioinfo $(NAME)-$(VERSION)-toolbox-bioinfo
	rm -rf $(PKGROOT)/toolbox/bioinfo

	rocks create package $(PKGROOT)/toolbox $(NAME)-$(VERSION)-toolbox
	rm -rf $(PKGROOT)/toolbox/

	rocks create package $(PKGROOT)/mcr/$(MCRVER) $(NAME)-$(VERSION)-mcr
	rm -rf $(PKGROOT)/mcr/$(MCRVER)/

	rocks create package $(PKGROOT)/bin $(NAME)-$(VERSION)-bin
	rm -rf $(PKGROOT)/bin

	rocks create package $(PKGROOT)/help/symbolic $(NAME)-$(VERSION)-help-symbolic
	rm -rf $(PKGROOT)/help/symbolic

	rocks create package $(PKGROOT)/help/matlab $(NAME)-$(VERSION)-help-matlab
	rm -rf $(PKGROOT)/help/matlab

	rocks create package $(PKGROOT)/help/simulink $(NAME)-$(VERSION)-help-simulink
	rm -rf $(PKGROOT)/help/simulink

	rocks create package $(PKGROOT)/help/helpsearch $(NAME)-$(VERSION)-help-helpsearch
	rm -rf $(PKGROOT)/help/helpsearch

	rocks create package $(PKGROOT)/help $(NAME)-$(VERSION)-help
	rm -rf $(PKGROOT)/help

	rocks create package $(PKGROOT) $(NAME)-$(VERSION)
	rm -rf $(PKGROOT)

	# the $(DATA)  must have enough space ~5Gb for rpms
	mkdir -p $(DATA)/$(VERSION)/
	-cp *.$(ARCH).rpm $(DATA)/$(VERSION)/

build:
	echo "run make pre-build and mcr targets by hand"

rpm:: build


install::
	echo "Nothing to install"

clean::
	rm -rf installer_input version.mk
