
.. hightlight:: rest

MATLAB roll
=============================
.. contents::  


Introduction
------------------
This roll installs MATLAB  in /share/apps/matlab 
Need an access to download matlab distro from UCSD ACT.
Instructions are updated for 2015a.

Download
~~~~~~~~~~~

#. Get source ISO (~6Gb), network.lic, FIK.txt from https://matlab.ucsd.edu/software/ 

#. Get Matlab Runtime Compiler (zip file) 
   from http://www.mathworks.com/products/compiler/mcr/
   Note mcr version from the download site, for example R2015a (8.5)

#. Put ISO and zip in $DATA (defined in src/matlab/versin.mk.in). 

#. Copy network.lic to src/matlab/license.dat
   Example license.dat: ::

        # MathWorks license passcode file.
        # LicenseNo: 206XXX   HostID: 782BCB3F1XXX
        #                     HostID: 782BCB3EEXXX
        #                     HostID: 782BCB3F1XXX
        #
        SERVER acms-flexlm-lnx4.ucsd.edu 782bcb3f1XXX 1727
        SERVER acms-flexlm-lnx5.ucsd.edu 782bcb3eeXXX 1727
        SERVER acms-flexlm-lnx6.ucsd.edu 782bcb3f1XXX 1727
        
        USE_SERVER

#. Create src/matlab/FileInstallationKey.txt from FIK.txt - use one line key for a specific matlab version.

   Example FileInstallationKey.txt: ::

        11111-22222-33333-15778-53320-40678-52617-42297-51152-04249-33677-09537


#. Update matlab.mk with new matlab and mcr version

Create Roll
--------------

#. Make sure there is enough space in  matlab roll directory to hold matlab RPMs (~6Gb),
   roll ISOs (~6Gb).

#. Make sure there is enough space in /var, /state/partition1/, /tmp for roll creation.
   Reset TMPDIR to a partition that has enough space.  For example: ::

       # export TMPDIR=/state/partition1/var

#. Create all needed RPMs from matlab distro.  The RPMs will be placed in RPMS/$(ARCH): ::

       # ./bootstrap.sh

   Check /tmp/matlab.log and /tmp/malab-mcr.log files.


#. From the top level of roll distro create a roll: ::

      # make roll

Install Roll
--------------

The matlab roll can be added to a live server ::

      # rocks add roll matlab*iso
      # rocks enable roll matlab
      # (cd /export/rocks/install; rocks create distro)
      # rocks run roll matlab > add-matlab.sh
      # bash add-roll.sh  > add-roll.out 2>&1

Install roll on compute nodes: ::

      # rocks run host compute login "yum clean all; yum install matlab-module"
