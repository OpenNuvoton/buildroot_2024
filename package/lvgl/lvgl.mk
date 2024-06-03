################################################################################
#
# lvgl
#
# Integrated in Buildroot by Nuvoton Corporation (Shanghai), twjiang@nuvoton.com
#
################################################################################

LVGL_VERSION = origin/master
LVGL_SITE = https://github.com/lvgl/lv_port_linux.git
LVGL_SITE_METHOD = git
LVGL_GIT_SUBMODULES = YES
LVGL_INSTALL_STAGING = YES
LVGL_LICENSE = MIT
LVGL_LICENSE_FILES = LICENSE

LVGL_DEPENDENCIES = host-cmake

define LVGL_REMOVE_HEADER_FILES
        rm -Rf $(TARGET_DIR)/usr/include/lvgl
endef
LVGL_POST_INSTALL_TARGET_HOOKS += LVGL_REMOVE_HEADER_FILES

define LVGL_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(@D)/bin/main $(TARGET_DIR)/usr/bin/lvgl_main
        $(INSTALL) -D -m 0755 $(LVGL_PKGDIR)/S90lvgld \
                $(TARGET_DIR)/etc/init.d/S90lvgld
endef

$(eval $(cmake-package))
