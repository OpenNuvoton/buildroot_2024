################################################################################
#
# parted
#
################################################################################

PARTED_VERSION = 3.3
PARTED_SOURCE = parted-$(PARTED_VERSION).tar.xz
PARTED_SITE = $(BR2_GNU_MIRROR)/parted
PARTED_DEPENDENCIES = host-pkgconf util-linux
PARTED_INSTALL_STAGING = YES
PARTED_LICENSE = GPL-3.0+
PARTED_LICENSE_FILES = COPYING
PARTED_CPE_ID_VALID = YES

ifeq ($(BR2_PACKAGE_READLINE),y)
PARTED_DEPENDENCIES += readline
PARTED_CONF_OPTS += --with-readline
else
PARTED_CONF_OPTS += --without-readline
endif

ifeq ($(BR2_PACKAGE_LVM2),y)
PARTED_DEPENDENCIES += lvm2
PARTED_CONF_OPTS += --enable-device-mapper
else
PARTED_CONF_OPTS += --disable-device-mapper
endif

ifeq ($(BR2_PACKAGE_LIBICONV),y)
PARTED_DEPENDENCIES += libiconv
endif

HOST_PARTED_DEPENDENCIES = host-pkgconf host-util-linux
HOST_PARTED_CONF_OPTS = \
	--disable-silent-rules \
	--disable-dependency-tracking \
	--disable-device-mapper \
	--disable-nls \
	--without-readline

define HOST_PARTED_CONFIGURE_CMDS
	(cd $(@D); rm -rf config.cache; \
		$(HOST_CONFIGURE_ARGS) \
		$(HOST_CONFIGURE_OPTS) \
		./configure \
		--prefix="$(HOST_DIR)" \
		$(HOST_PARTED_CONF_OPTS) \
	)
endef


define HOST_PARTED_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE1) -C $(@D)
endef

define HOST_PARTED_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE1) -C $(@D) install
endef


$(eval $(autotools-package))
$(eval $(host-generic-package))
