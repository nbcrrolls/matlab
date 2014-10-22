
.. hightlight:: rest

MATLAB roll
=============================
.. contents::  


Introduction
------------------
This roll installs MATLAB  in /share/apps/matlab 
Need an access to download matlab distro from UCSD ACT.
Instructions were created for matlab 2012a

Download
~~~~~~~~~~~

#. get source ISO, unpack ::

	# mount oec-storage02.ucsd.edu:/export/apps/matlab /tmp/mnt/
	# (cd /tmp/mnt/; tar czvf - R2012a) | split -d -b 200m - matlab-2012a-
	# cp /tmp/mnt/R2012a/FileInstallationKey.txt .
	# cp /tmp/mnt/R2012a/License.lic .

   scp key, license and all matlab chunks to roll's matlab/src/matlab/ directory. 

   When need to combine files do in Makefile build target: ::

	# cat matlab-2012a-?? | tar zxvf - 

   Example FileInstallationKey.txt: ::

        11111-22222-33333-15778-53320-40678-52617-42297-51152-04249-33677-09537

   Example License.lic: ::

        # MathWorks license passcode file.
        # LicenseNo: 206XXX   HostID: 782BCB3F1XXX
        #                     HostID: 782BCB3EEXXX
        #                     HostID: 782BCB3F1XXX
        #
        SERVER acms-flexlm-lnx4.ucsd.edu 782bcb3f1XXX 1727
        SERVER acms-flexlm-lnx5.ucsd.edu 782bcb3eeXXX 1727
        SERVER acms-flexlm-lnx6.ucsd.edu 782bcb3f1XXX 1727
        
        USE_SERVER

#.  download Matlab Runtime Compiler (zip fiel), put in matlab/src/matlab

Create Roll
--------------

#. Install matlab in /share/apps/matlab/$VERSION: ::

       # cd matlab/src/matlab
       # make pre-build

#. Create a directory on a partition  to hold about 2.5Gb for creating and saving  RPMS 
   outside of the roll.  The root directory is identified in src/matlab/version.mk as DATA

#. After a successful install (check log) create rpms:

       # cd matlab/src/matlab
       # make pre-rpm
   
    this will save the resulting rpms 


#. from the top level of roll distro create a roll: ::

      # make roll

Install Roll
--------------

Make sure that created matlab RPMS are available in $(DATA). The roll
psot section expects DATA=/data/root

      # ls /data/root

The matlab roll can be added to a live server ::

      # rocks add roll matlab-*.x86_64.disk1.iso
      # rocks enable roll matlab
      # (cd /export/rocks/install; rocks create distro)
      # yum clean all
      # rocks run roll matlab | bash
      # bash add-roll.sh  > add-roll.out 2>&1

Install roll on compute nodes: ::

      # rocks run host compute login "yum clean all; yum install rocks-matlab"
