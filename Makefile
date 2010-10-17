#
# Copyright 2010 Grigale Ltd. All rights reserved.
# Use is subject to license terms.
#
.KEEP_STATE:


all:
	cd libiscsitgt; $(MAKE) all
	cd iscsitadm; $(MAKE) all
	cd iscsitgtd; $(MAKE) all
	cd pkg; pkgmk -o -f slit.prototype -d .
