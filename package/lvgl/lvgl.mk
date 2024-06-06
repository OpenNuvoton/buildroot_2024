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

define LVGL_CONFIGURE_TOUCHSCREEN
        @if grep -Eq "^BR2_PACKAGE_LVGL_DEFAULT_RESISTIVE_TOUCHSCREEN=y$\" ${BR2_CONFIG}; then \
		sed -i 's/#define LV_USE_EVDEV.*/#define LV_USE_EVDEV    0/' $(@D)/lv_conf.h; \
		sed -i 's/#define LV_USE_TSLIB.*/#define LV_USE_TSLIB    1/' $(@D)/lv_conf.h; \
		sed -i 's/##TSLIB_LIBRARIES##/ts/' $(@D)/CMakeLists.txt; \
	fi

        @if grep -Eq "^BR2_PACKAGE_LVGL_DEFAULT_CAPACITIVE_TOUCHSCREEN=y$\" ${BR2_CONFIG}; then \
		sed -i 's/#define LV_USE_EVDEV.*/#define LV_USE_EVDEV    1/' $(@D)/lv_conf.h; \
		sed -i 's/#define LV_USE_TSLIB.*/#define LV_USE_TSLIB    0/' $(@D)/lv_conf.h; \
		sed -i 's/##TSLIB_LIBRARIES##//' $(@D)/CMakeLists.txt; \
        fi
endef
LVGL_POST_PATCH_HOOKS += LVGL_CONFIGURE_TOUCHSCREEN

define LVGL_REMOVE_HEADER_FILES
        rm -Rf $(TARGET_DIR)/usr/include/lvgl
	rm -Rf $(TARGET_DIR)/usr/lib/pkgconfig
endef
LVGL_POST_INSTALL_TARGET_HOOKS += LVGL_REMOVE_HEADER_FILES

define LVGL_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(@D)/bin/main \
		$(TARGET_DIR)/usr/bin/lvgl_main

	$(INSTALL) -D -m 0755 $(LVGL_PKGDIR)/S90lvgld \
		$(TARGET_DIR)/etc/init.d/S90lvgld

	@if grep -Eq "^BR2_PACKAGE_LVGL_DEFAULT_RESISTIVE_TOUCHSCREEN=y$\" ${BR2_CONFIG}; then \
		sed -i 's/##//' $(TARGET_DIR)/etc/init.d/S90lvgld; \
	fi
endef

$(eval $(cmake-package))
