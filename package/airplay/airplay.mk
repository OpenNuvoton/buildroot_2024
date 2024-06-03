################################################################################
#
# airplay
#
# Integrated in Buildroot by Nuvoton 2023 twjiang@nuvoton.com
#
################################################################################

AIRPLAY_VERSION = 3de745e53b69eaf12e8ef9d982a688db8c2966e2
AIRPLAY_SITE = $(call github,FDH2,UxPlay,$(AIRPLAY_VERSION))
AIRPLAY_LICENSE = GPL-3.0
AIRPLAY_LICENSE_FILES = LICENSE

AIRPLAY_DEPENDENCIES = host-cmake libplist libopenssl libcap avahi gstreamer1 gst1-plugins-base \
	gst1-plugins-good gst1-plugins-bad

AIRPLAY_CONF_OPTS = -DNO_X11_DEPS=ON

define AIRPLAY_INSTALL_INIT_SYSV
        $(INSTALL) -D -m 0755 package/airplay/S70airplay \
                $(TARGET_DIR)/etc/init.d/S70airplay
endef

define AIRPLAY_REMOVE_UNEEDED_FILES
        $(RM) -r $(TARGET_DIR)/
endef

#AIRPLAY_TARGET_FINALIZE_HOOKS += AIRPLAY_REMOVE_UNEEDED_FILES

$(eval $(cmake-package))
