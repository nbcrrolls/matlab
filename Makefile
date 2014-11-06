#
# @Copyright@
# @Copyright@
#

-include $(ROLLSROOT)/etc/Rolls.mk
include Rolls.mk
include matlab.mk

default: 
	for i in `ls nodes/*.xml.in`; do \
	    export o=`echo $$i | sed 's/\.in//'`; \
	    cp $$i $$o; \
	    sed -i "s/MATLABVER/$(MATLABVER)/g" $$o; \
	    sed -i "s%DATA%$(DATA)%g" $$o; \
	done
	$(MAKE) roll

cvsclean::
	for i in `ls nodes/*.xml.in`; do \
	    export o=`echo $$i | sed 's/\.in//'`; \
	    rpm -rf  $$o; \
	done

clean::
	rm -rf _arch

