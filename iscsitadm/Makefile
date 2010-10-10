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

PROG = iscsitadm
OBJS = main.o helper.o cmdparse.o
SRCS =$(OBJS:%.o=%.c)
POFILES= $(OBJS:%.o=%.po)

MACH		= -m64
CFLAGS		= $(MACH)
CFLAGS		+= -g -xO0
CFLAGS		+= $(CCVERBOSE)

CPPFLAGS	= -I/usr/include/libxml2
CPPFLAGS	+= -I../libiscsitgt
CPPFLAGS	+= -I../include
FILEMODE= 0555
LDFLAGS		= -L../libiscsitgt
LDLIBS		= -liscsitgt -lxml2


all: $(PROG)

install: all $(ROOTUSRSBINPROG)

$(PROG): $(OBJS) $(COMMON_OBJS)
	$(LINK.c) -o $(PROG) $(OBJS) $(COMMON_OBJS) $(LDLIBS) $(XMLLIB)
	$(POST_PROCESS)

catalog:	$(POFILE)

lint	:= LINTFLAGS += -u
lint	:= LINTFLAGS64 += -u

lint:	$$(SRCS)
	$(LINT.c) $(SRCS) $(LDLIBS)

$(POFILE): $(POFILES)
	$(RM) $@
	cat $(POFILES) > $@

%.o : $(ISCSICOMMONDIR)/%.c
	$(COMPILE.c) -o $@ $<
	$(POST_PROCESS_O)

clean:
	-$(RM) $(OBJS) $(PROG) 
