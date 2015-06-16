#
# @Copyright@
# @Copyright@
#

KEY=$(shell cat FileInstallationKey.txt)

REDHAT.ROOT = $(PWD)/../../
-include $(ROCKSROOT)/etc/Rules.mk

SEDSPEC += \
	-e 's%PKGROOT%$(PKGROOT)%g' \
	-e 's%ROLLPATH%$(PWD)%g' \
	-e "s%KEY%$(KEY)%g" \

pretar:: $(VERSION.MK.INCLUDE)

$(VERSION.MK.INCLUDE): 
	if [ -f $(VERSION.MK.MASTER) ]; then \
	    /bin/cp $(VERSION.MK.MASTER) $@; \
	fi

%: %.in
	$(SED) $(SEDSCRIPT) $^ > $@


installer_input: installer_input.in
	$(SED) $(SEDSPEC) $^ > $@


pre-build: version.mk installer_input

	# mount iso and copy contents
	mkdir -p $(NAME)-$(VERSION)
	mount -o loop $(ISODISTRO) /mnt/cdrom
	cp -p -r /mnt/cdrom/* $(NAME)-$(VERSION)/
	umount /mnt/cdrom

	# build matlab distro
	cp installer_input  $(NAME)-$(VERSION)/
	mkdir -p  $(PKGROOT)
	( \
	    cd $(NAME)-$(VERSION); \
	    ./install -tmpdir $(VARDIR) -inputFile installer_input ; \
	)

	# build matlab MCR distro
	mkdir $(MCR)
	(cd $(MCR); unzip $(MCRDISTRO))
	cp installer_input $(MCR)/
	$(SED) -i "s/matlab\.log/matlab-mcr\.log/" $(MCR)/installer_input
	( \
	    cd $(MCR); \
	    ./install -tmpdir $(VARDIR) -inputFile installer_input ; \
	)

	# remove intalled license before making packages
	rm -rf $(PKGROOT)/licenses/network.lic

	# remove unpacked distro 
	rm -rf $(NAME)-$(VERSION)
	rm -rf $(MCR)

prep-rpm:: version.mk pre-build 

	# set temp dir to use as TMPDIR
	mkdir -p $(VARDIR)
	export TMPDIR=$(VARDIR)

	rocks create package $(PKGROOT)/toolbox/compiler $(NAME)-$(VERSION)-toolbox-compiler
	rm -rf $(PKGROOT)/toolbox/compiler/

	rocks create package $(PKGROOT)/toolbox/vision $(NAME)-$(VERSION)-toolbox-vision
	rm -rf $(PKGROOT)/toolbox/vision

	rocks create package $(PKGROOT)/toolbox/simulink $(NAME)-$(VERSION)-toolbox-simulink
	rm -rf $(PKGROOT)/toolbox/simulink

	rocks create package $(PKGROOT)/toolbox/images $(NAME)-$(VERSION)-toolbox-images
	rm -rf $(PKGROOT)/toolbox/images

	rocks create package $(PKGROOT)/toolbox/comm $(NAME)-$(VERSION)-toolbox-comm
	rm -rf $(PKGROOT)/toolbox/comm

	rocks create package $(PKGROOT)/toolbox/bioinfo $(NAME)-$(VERSION)-toolbox-bioinfo
	rm -rf $(PKGROOT)/toolbox/bioinfo

	rocks create package $(PKGROOT)/toolbox/matlab $(NAME)-$(VERSION)-toolbox-matlab
	rm -rf $(PKGROOT)/toolbox/matlab

	rocks create package $(PKGROOT)/toolbox/shared $(NAME)-$(VERSION)-toolbox-shared
	rm -rf $(PKGROOT)/toolbox/shared

	rocks create package $(PKGROOT)/toolbox/sl3d $(NAME)-$(VERSION)-toolbox-sl3d
	rm -rf $(PKGROOT)/toolbox/sl3d

	rocks create package $(PKGROOT)/toolbox $(NAME)-$(VERSION)-toolbox
	rm -rf $(PKGROOT)/toolbox/

	rocks create package $(PKGROOT)/$(MCRVER)/bin $(NAME)-$(VERSION)-mcr-$(MCRVER)-bin
	rm -rf $(PKGROOT)/$(MCRVER)/bin

	rocks create package $(PKGROOT)/$(MCRVER) $(NAME)-$(VERSION)-mcr-$(MCRVER)
	rm -rf $(PKGROOT)/$(MCRVER)

	rocks create package $(PKGROOT)/bin $(NAME)-$(VERSION)-bin
	rm -rf $(PKGROOT)/bin

	rocks create package $(PKGROOT)/help/symbolic $(NAME)-$(VERSION)-help-symbolic
	rm -rf $(PKGROOT)/help/symbolic

	rocks create package $(PKGROOT)/help/examples $(NAME)-$(VERSION)-help-examples
	rm -rf $(PKGROOT)/help/examples

	rocks create package $(PKGROOT)/help/matlab $(NAME)-$(VERSION)-help-matlab
	rm -rf $(PKGROOT)/help/matlab

	rocks create package $(PKGROOT)/help/simulink $(NAME)-$(VERSION)-help-simulink
	rm -rf $(PKGROOT)/help/simulink

	rocks create package $(PKGROOT)/help/dsp $(NAME)-$(VERSION)-help-dsp
	rm -rf $(PKGROOT)/help/dsp

	rocks create package $(PKGROOT)/help $(NAME)-$(VERSION)-help
	rm -rf $(PKGROOT)/help

	rocks create package $(PKGROOT) $(NAME)-$(VERSION)-base
	rm -rf $(PKGROOT)

	# the $(DATA)  must have enough space ~5Gb for rpms
	mkdir -p $(DATA)/$(VERSION)/
	-cp *.$(ARCH).rpm $(DATA)/$(VERSION)/

	# remove temp dir used as TMPDIR
	rm -rf $(VARDIR)

	# move rpms to rolls RPMS/
	if [ ! -d $(REDHAT.ROOT)/RPMS/$(ARCH) ]; then \
	    mkdir -p $(REDHAT.ROOT)/RPMS/$(ARCH); \
	fi
	for rpm in `find . -name '$(NAME)-$(VERSION)*$(ARCH).rpm'`; do        \
	    echo "Copying $$rpm";                       \
	    /bin/mv $$rpm $(REDHAT.ROOT)/RPMS/$(ARCH);  \
	done

build: 
	echo "Nothing to do. Make sure bootstrap.sh was run in $(REDHAT.ROOT)"
	
rpm:: 
	echo "Nothing to do. RPMs were created in bootstrap.sh"


install::
	echo "Nothing to install"

clean::
	rm -rf installer_input version.mk
	rm -rf $(VERSION.MK.INCLUDE)
