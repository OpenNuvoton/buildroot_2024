################################################################################
#
# nu-hmi-controller
#
################################################################################

NU_HMI_CONTROLLER_VERSION = v1.0
NU_HMI_CONTROLLER_SITE = https://github.com/OpenNuvoton/MA35D1_Graphics.git
NU_HMI_CONTROLLER_SITE_METHOD = git
NU_HMI_CONTROLLER_SUBDIR = weston/ivi/nu-hmi-controller

NU_HMI_CONTROLLER_DEPENDENCIES = weston

# Always clean before build, since Buildroot reuses the extracted source
# tree and these custom build commands don't track staleness themselves
define NU_HMI_CONTROLLER_PRE_BUILD_CLEAN
	rm -rf $(NU_HMI_CONTROLLER_SRCDIR)/build
endef
NU_HMI_CONTROLLER_PRE_BUILD_HOOKS += NU_HMI_CONTROLLER_PRE_BUILD_CLEAN

# This BSP's weston recipe is Weston 10.0.5 (libweston-10), which
# matches the package Makefile's own WESTON_MAJOR?=10 default - no
# override needed here (contrast Yocto's nu-hmi-controller recipe,
# whose Weston 13.0.1 does require WESTON_MAJOR=13).
define NU_HMI_CONTROLLER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		-C $(NU_HMI_CONTROLLER_SRCDIR) \
		SYSROOT=$(STAGING_DIR) \
		all
endef

define NU_HMI_CONTROLLER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(NU_HMI_CONTROLLER_SRCDIR)/build/nu-hmi-controller.so \
		$(TARGET_DIR)/usr/lib/weston/nu-hmi-controller.so
endef

$(eval $(generic-package))
