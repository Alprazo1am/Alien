ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0
THEOS_PACKAGE_SCHEME = rootless
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Alien
Alien_FILES = Tweak.xm
Alien_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
