#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright 2010 Grigale Ltd.  All rights reserved.
# Use is subject to license terms.
#

.KEEP_STATE:

DTRACE	= dtrace
PROG	= iscsitgtd

# Conditional features
FEATURES	=

# ENABLE_EARLY_PGR_LOAD - allows iscsitgtd to load the PGR data as soon as
# the I_T_L nexus is created, rather than delay it until the first SCSI
# command arrives
FEATURES	+= -DENABLE_EARLY_PGR_LOAD

DSRC	= iscsi_provider.d
DHEADER	= $(DSRC:%.d=%.h)
DLIBSRCS = iscsi.d

OBJS	= main.o mgmt.o mgmt_create.o mgmt_list.o mgmt_modify.o mgmt_remove.o
OBJS	+= iscsi_authclient.o iscsi_authglue.o iscsi_cmd.o iscsi_conn.o
OBJS	+= iscsi_crc.o iscsi_ffp.o iscsi_login.o iscsi_sess.o radius.o
OBJS	+= t10_sam.o t10_spc.o t10_sbc.o t10_raw_if.o t10_ssc.o t10_osd.o
OBJS	+= t10_spc_pr.o util.o util_err.o util_ifname.o util_port.o util_queue.o
OBJS	+= isns_client.o isns.o mgmt_scf.o

DOBJ	= $(DSRC:%.d=%.o)

POFILE= iscsitgtd.po
POFILES	= $(OBJS:%.o=%.po)

MACH	= -m64

MANIFEST	= iscsi_target.xml
SVCMETHOD	= svc-iscsitgt

ROOTMANIFESTDIR	= $(ROOTSVCSYSTEM)
$(ROOTSVCSYSTEM)/iscsi_target.xml	:= FILEMODE = 0444


ROOTDLIBDIR = $(ROOT)/usr/lib/dtrace
ROOTDLIBS = $(DLIBSRCS:%=$(ROOTDLIBDIR)/%)
$(ROOTDLIBS) := FILEMODE = 0644

CFLAGS		= -g -xO0
CFLAGS		+= $(MACH)

#CPPFLAGS += -D_FILE_OFFSET_BITS=64 -I${ISCSICOMMONDIR} -I${HDCRCCOMMONDIR}
CPPFLAGS	= -I/usr/include/libxml2
CPPFLAGS	+= -I../libiscsitgt
CPPFLAGS	+= -I../include

CPPFLAGS	+= $(FEATURES)

LDLIBS		= -lsocket -lnsl -ldoor -lumem -lscf -lmd -luuid -lefi -lxml2
LDLIBS		+= -ladm -laio -lrt -lsasl -lzfs -lavl -ldlpi
LDLIBS		+= -liscsitgt


LDFLAGS		= -L../lib64 -L../libiscsitgt

%.h:	%.d
	$(DTRACE) -xnolibs -h -s $< -o $@

%.o:	%.d $(OBJS)
	$(DTRACE) -G -64 -xnolibs -s $< $(OBJS)

all:	$(PROG)


$(PROG): $(DHEADER) $(OBJS) $(DOBJ)
	$(CC) -o $@ $(MACH) $(LDFLAGS) $(LDLIBS) $(OBJS)

install: $(SUBDIRS) $(ROOTMANIFEST) $(ROOTDLIBS) $(ROOTSVCMETHOD)
	-$(RM) $(ROOTUSRSBINPROG)
	-$(LN) $(ISAEXEC) $(ROOTUSRSBINPROG)

catalog:	$(POFILE)

$(POFILE): $(POFILES)
	$(RM) $@
	cat $(POFILES) > $@

clean:
	$(RM) $(DHEADER) $(OBJS) $(PROG)

