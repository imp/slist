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

LN =		ln
LIBRARY =	libiscsitgt.so
VERS =		.1
OBJECTS =	if_zfs.o if_gen.o xml.o gen.o

SRCDIR = 	.

TARGET =		$(LIBRARY)$(VERS)
LDLIBS +=	-lscf -lc
$(DYNLIB) :=	LDLIBS += -lxml2
SRCS =		$(OBJECTS:%.o=$(SRCDIR)/%.c)

$(LINTLIB) :=	SRCS = $(SRCDIR)/$(LINTSRC)

MACH =		-m64
CFLAGS =	-Kpic
CFLAGS +=	-g -xO0
CFLAGS +=	$(CCVERBOSE)
CFLAGS +=	$(MACH)
CPPFLAGS +=	-I/usr/include/libxml2 -I$(SRCDIR) -I../include \
    -I../iscsitgtd

.KEEP_STATE:

all: $(LIBRARY)

$(TARGET): $(OBJECTS)
	$(CC) $(MACH) -G -h $@ -o $@ $(OBJECTS) $(LDLIBS)

$(LIBRARY): $(TARGET)
	$(LN) -s ./$(TARGET) $(LIBRARY)

clean:
	$(RM) $(OBJECTS) $(TARGET) $(LIBRARY)
