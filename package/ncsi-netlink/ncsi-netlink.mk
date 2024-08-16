################################################################################
#
# ncsi-netlink
#
################################################################################

NCSI_NETLINK_VERSION=1.0.0
NCSI_NETLINK_SITE = $(call github,sammj,ncsi-netlink,master)
NCSI_NETLINK_LICENSE = GPL2
NCSI_NETLINK_LICENSE_FILES = LICENSE
NCSI_NETLINK_INSTALL_STAGING = YES
NCSI_NETLINK_DEPENDENCIES += libnl
NCSI_NETLINK_CFLAGS = $(TARGET_CFLAGS)
NCSI_NETLINK_CONF_OPTS += --with-libnl

NCSI_NETLINK_MAKE_OPTS = CFLAGS="$(NCSI_NETLINK_CFLAGS)" LIBNL_INCDIR=$(STAGING_DIR)/usr/include/libnl3 LIBNL_LIBDIR=$(STAGING_DIR)/usr/lib/libnl3

define NCSI_NETLINK_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		$(NCSI_NETLINK_MAKE_OPTS) all
endef

define NCSI_NETLINK_INSTALL_TARGET_CMDS
        ( rm -f $(TARGET_DIR)/opt/ncsi-netlink* && cp -a $(@D)/ncsi-netlink $(TARGET_DIR)/opt/ ) || exit 1;
endef


$(eval $(generic-package))
