
.. hightlight:: rest

MATLAB roll
=============================
.. contents::  


Introduction
------------------
This roll installs MATLAB  in /share/apps/matlab 
Need an access to download matlab distro from UCSD ACT.
Instructions are updated for 2013a (changed since  matlab 2012a)

Download
~~~~~~~~~~~

#. get source ISO (~6Gb),  network.lic, FIL.tzt from https://matlab.ucsd.edu/software/ 

#. unpack ::

	# cd <path-to-matlab-roll>/src/matlab
	# mkdir matlab-2013a/
	# mount -o loop /data/root/matlab/2013a/R2013A_UNIX.iso /mnt/cdrom/
	# cp -p -r /mnt/cdrom/* matlab-2013a/
	# cp /data/root/matlab/2013a/network.lic license.dat 
	# cp /data/root/matlab/2013a/FIK.txt .

   Create FileInstallationKey.txt from FIK.txt (key for specific matlab version) 

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

#.  download from http://www.mathworks.com/products/compiler/mcr/
    Matlab Runtime Compiler (zip file), put in matlab/src/matlab


Create Roll
--------------

#. Install matlab in /share/apps/matlab/$VERSION: ::

       # cd matlab/src/matlab
       # make pre-build
       # make mcr

   NOTE: as of 2013a targets ``pre-build`` and ``mcr`` don't work, matlab installer exits. 
   Install matlab using Makefile commands for these targets (without -inputFile) via GUI.

#. Have a directory on a partition to hold ~5Gb for creating and saving RPMS 
   outside of the roll.  The root directory is identified in src/matlab/version.mk as DATA

#. Create a directory on a partition  to hold about 2.5Gb for creating and saving  RPMS 
   outside of the roll.  The root directory is identified in src/matlab/version.mk as ``DATA``

   After a successful install (check log) create rpms: ::

       # cd matlab/src/matlab
       # make prep-rpm
   
   this will save the resulting rpms 


#. From the top level of roll distro create a roll: ::

      # make roll

Install Roll
--------------

Make sure that created matlab RPMS are available in $DATA. ::

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
