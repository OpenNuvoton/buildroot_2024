################################################################################
#
# nu-lvgl
#
################################################################################

NU_LVGL_VERSION = 927d052510a240d0c1d14928fb6d01a2363ebce9
NU_LVGL_SITE = https://github.com/lvgl/lv_port_linux.git
NU_LVGL_SITE_METHOD = git
NU_LVGL_GIT_SUBMODULES = YES
NU_LVGL_INSTALL_STAGING = YES
NU_LVGL_LICENSE = MIT
NU_LVGL_LICENSE_FILES = LICENSE

NU_LVGL_DEPENDENCIES = host-cmake wayland wayland-protocols

#NU_LVGL_CONF_OPTS = -DBUILD_SHARED_LIBS=OFF

define LVGL_GENERATE_WAYLAND_PROTOCOLS_CLIENT_FILES
	mkdir -p $(@D)/lv_drivers/wayland/protocols && \
	\
	$(HOST_DIR)/bin/wayland-scanner private-code \
	$(STAGING_DIR)/usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml \
	$(@D)/lv_drivers/wayland/protocols/xdg-shell-protocol.c && \
	\
	$(HOST_DIR)/bin/wayland-scanner client-header \
	$(STAGING_DIR)/usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml \
	$(@D)/lv_drivers/wayland/protocols/xdg-shell-client-protocol.h
endef
NU_LVGL_PRE_CONFIGURE_HOOKS += LVGL_GENERATE_WAYLAND_PROTOCOLS_CLIENT_FILES

define LVGL_TARGET_INSTALL_CMD
	$(INSTALL) -m 0755 -D $(NU_LVGL_PKGDIR)/lvgl.png \
        	$(TARGET_DIR)/usr/share/weston/lvgl.png
endef
NU_LVGL_POST_INSTALL_TARGET_HOOKS += LVGL_TARGET_INSTALL_CMD

define LVGL_REMOVE_HEADER_FILES
        rm -Rf $(TARGET_DIR)/usr/include/lvgl
endef
NU_LVGL_POST_INSTALL_TARGET_HOOKS += LVGL_REMOVE_HEADER_FILES

$(eval $(cmake-package))
