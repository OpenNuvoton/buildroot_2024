################################################################################
#
# libetna2d
#
################################################################################

LIBETNA2D_VERSION = v1.0
LIBETNA2D_SITE = https://github.com/OpenNuvoton/MA35D1_Graphics.git
LIBETNA2D_SITE_METHOD = git
LIBETNA2D_SUBDIR = drm/libetna2d

LIBETNA2D_DEPENDENCIES = libdrm
LIBETNA2D_INSTALL_STAGING = YES

# Always clean before build, since Buildroot reuses the extracted source
# tree and these custom build commands don't track staleness themselves
define LIBETNA2D_PRE_BUILD_CLEAN
	rm -rf $(LIBETNA2D_SRCDIR)/build
endef
LIBETNA2D_PRE_BUILD_HOOKS += LIBETNA2D_PRE_BUILD_CLEAN

# The package's own Makefile already understands cross-building (CC/AR
# honour command-line overrides, CFLAGS/LDFLAGS take a SYSROOT); just
# feed it Buildroot's toolchain + staging locations.
define LIBETNA2D_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		-C $(LIBETNA2D_SRCDIR) \
		SYSROOT=$(STAGING_DIR) \
		LIBDRM=$(LIBETNA2D_SRCDIR)/third_party/libdrm-etnaviv-private \
		all
endef

define LIBETNA2D_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(LIBETNA2D_SRCDIR)/etna2d.h $(STAGING_DIR)/usr/include/etna2d.h
	$(INSTALL) -D -m 0755 $(LIBETNA2D_SRCDIR)/build/libetna2d.so.1 \
		$(STAGING_DIR)/usr/lib/libetna2d.so.1
	ln -sf libetna2d.so.1 $(STAGING_DIR)/usr/lib/libetna2d.so
endef

define LIBETNA2D_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(LIBETNA2D_SRCDIR)/build/libetna2d.so.1 \
		$(TARGET_DIR)/usr/lib/libetna2d.so.1
	ln -sf libetna2d.so.1 $(TARGET_DIR)/usr/lib/libetna2d.so
endef

$(eval $(generic-package))
