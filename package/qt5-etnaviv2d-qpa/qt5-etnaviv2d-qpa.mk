################################################################################
#
# qt5-etnaviv2d-qpa
#
################################################################################

QT5_ETNAVIV2D_QPA_VERSION = v1.0
QT5_ETNAVIV2D_QPA_SITE = https://github.com/OpenNuvoton/MA35D1_Graphics.git
QT5_ETNAVIV2D_QPA_SITE_METHOD = git
QT5_ETNAVIV2D_QPA_SUBDIR = qt/etnaviv2d-qpa

# wayland-protocols is not a build dependency - the plugin's Wayland
# protocol bindings are pre-generated and checked into
# src/wayland-protocols/, so there is no wayland-scanner codegen step.
QT5_ETNAVIV2D_QPA_DEPENDENCIES = libetna2d wayland

# Always clean before build, since Buildroot reuses the extracted source
# tree and these custom build commands don't track staleness themselves
define QT5_ETNAVIV2D_QPA_PRE_CONFIGURE_CLEAN
	rm -f $(QT5_ETNAVIV2D_QPA_SRCDIR)/Makefile $(QT5_ETNAVIV2D_QPA_SRCDIR)/.qmake.stash \
		$(QT5_ETNAVIV2D_QPA_SRCDIR)/libqetnaviv2d.so
	rm -f $(QT5_ETNAVIV2D_QPA_SRCDIR)/*.o $(QT5_ETNAVIV2D_QPA_SRCDIR)/moc_*.cpp $(QT5_ETNAVIV2D_QPA_SRCDIR)/moc_*.h
	rm -rf $(@D)/etnaviv2d_benchmark-build
endef
QT5_ETNAVIV2D_QPA_PRE_CONFIGURE_HOOKS += QT5_ETNAVIV2D_QPA_PRE_CONFIGURE_CLEAN

# Point qetnaviv2d.pro at libetna2d's staged install instead of its
# standalone-build default.
QT5_ETNAVIV2D_QPA_CONF_OPTS = \
	qetnaviv2d.pro \
	ETNA2D_INCDIR=$(STAGING_DIR)/usr/include \
	ETNA2D_LIBDIR=$(STAGING_DIR)/usr/lib

# etnaviv2d_benchmark - a QPainter-based GPU-vs-CPU frame-rate benchmark,
# built once and run with QT_QPA_PLATFORM switched between etnaviv2d/linuxfb
# to compare.
define QT5_ETNAVIV2D_QPA_BUILD_BENCHMARK
	mkdir -p $(@D)/etnaviv2d_benchmark-build
	cd $(@D)/etnaviv2d_benchmark-build && \
		$(TARGET_MAKE_ENV) $(QT5_QMAKE) \
			$(QT5_ETNAVIV2D_QPA_SRCDIR)/tests/etnaviv2d_benchmark/etnaviv2d_benchmark.pro
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/etnaviv2d_benchmark-build
endef
QT5_ETNAVIV2D_QPA_POST_BUILD_HOOKS += QT5_ETNAVIV2D_QPA_BUILD_BENCHMARK

define QT5_ETNAVIV2D_QPA_INSTALL_BENCHMARK
	$(INSTALL) -D -m 0755 $(@D)/etnaviv2d_benchmark-build/etnaviv2d_benchmark \
		$(TARGET_DIR)/usr/bin/etnaviv2d_benchmark
endef
QT5_ETNAVIV2D_QPA_POST_INSTALL_TARGET_HOOKS += QT5_ETNAVIV2D_QPA_INSTALL_BENCHMARK

$(eval $(qmake-package))
