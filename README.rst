============
kk_backup_v1
============

A complete and easy-to-understand TAR and optical disc backup solution for Linux and macOS.

What it is good for
===================

It is intended for scenarios where you need an incremental backup solution for your
personal computer using an external drive, with occasional backups burned to optical
discs for off-site storage.


Requirements
============

You need:

1. An external drive

2. A DVD burner and a bunch of blank DVDs

3. Basic knowledge of Bash and Bash scripting — you must adapt the simple scripts
   to your scenario. In particular, you should be familiar with these commands::

       cd, cp, mv, rm, mount, umount, cat
       tar

   It is also recommended to be familiar with these commands::

       par2, openssl, split

4. GNU Tar installed. On Linux, it is usually available by default. On macOS,
   you must install it with Homebrew::

       brew install gnu-tar

5. At some point, you should take a look at all the scripts and read
   the comments.


Install
=======

Copy the scripts from ``bin`` to a directory in your ``PATH``, for example::

    /usr/local/bin/


Configure
=========

1. Modify these scripts::

       kk_backup_tar_create.sh
       kk_backup_tar_restore.sh

   to match the path to your backup directory on the external drive, for example::

       /mnt/debian_backup/tar_backup

2. Modify the paths you want to include in or exclude from backups in::

       kk_backup_tar_create.sh

3. If you use double-layer DVDs or Blu-ray discs, then in this script::

       kk_backup_dvd_prepare.sh

   increase the size of the generated files according to the capacity of your
   optical disc::

       Default DVD-R    46.5 MB:   split -d -a 4 -b 46500000
               DVD-R DL 84.5 MB:   split -d -a 4 -b 84500000
               BD-R    249.5 MB:   split -d -a 4 -b 249500000

4. If you use macOS, make sure all occurrences of ``tar`` are replaced with
   ``gtar``, which you installed with Homebrew.


Usage
=====

1 Create the first full backup
------------------------------

-  Create the initial TAR archive::

       kk_backup_tar_create.sh


2 Create an incremental backup
------------------------------

-  Just call the same script again::

       kk_backup_tar_create.sh


3 Burn backup to DVD
--------------------

1. Prepare files for the initial set of DVDs::

       cd /home/debian/tmp
       kk_backup_dvd_prepare.sh /mnt/debian_backup/tar_backup/backup_2026_01_01_T_00_00.*

   .. WARNING::

       It is useful to use the ``.*`` wildcard so that the corresponding ``snar``
       files are included on the DVDs as well.

2. Burn files to DVD with your favorite burning software.

   .. NOTE::

        Each DVD will contain a maximum of 100 split data files, except for the
        last DVDs, where the recovery PAR2 files must be placed manually to make
        use of the remaining free space on the disc.


4 Full recovery from DVD
------------------------

Use this procedure when your data has been lost from the external drive.

1. Copy all files from the DVDs to a local directory::

       cd /home/debian/tmp
       cp /mnt/cdrom0/* .
       cp /mnt/cdrom0/* .
       ...

2. Recover the original backup files from the DVD files::

       kk_backup_dvd_restore.sh dvd_backup_2026_01_01_T_00_00.tar.gz.ossl-aes-256-cbc.split_
       cd kk_output_dvd

   .. WARNING::

       Be precise with the prefix; it always ends with ``.split_``!

3. Move recovered backup files back to their original destination on your external drive::

       mv * /mnt/debian_backup/tar_backup

4. To recover the original directories and files backed up with tar, use::

       cd /mnt/debian_backup/tar_backup
       kk_backup_tar_restore.sh
       cd kk_output_tar


Known limitations
=================

-  The GNU Tar is unable to handle properly re-naming of the super-parent
   directory. This will be handled properly:

       Movies/Matrix/Matrix.avi -> Movies/Matrix_2/Matrix.avi

   However, in this scenario the Gnu Tar will include ``Matrix.avi`` into
   newly created incremental backup archive:

       Movies/Matrix/Matrix.avi -> Movies_2/Matrix/Matrix.avi

   Be aware that although this is not ideal, it's still better that
   incremental backups with ``rsync`` or ``duplicity`` which can't handle
   directory renaming at all.