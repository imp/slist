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

clean:
	cd libiscsitgt; $(MAKE) clean
	cd iscsitadm; $(MAKE) clean
	cd iscsitgtd; $(MAKE) clean
