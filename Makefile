ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0
THEOS_PACKAGE_SCHEME = rootless
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Alien
Alien_FILES = Tweak.xm
Alien_CFLAGS = -fobjc-arc

BUNDLE_NAME = AlienPrefs
AlienPrefs_FILES = AlienRootListController.m
AlienPrefs_INSTALL_PATH = /Library/PreferenceBundles
AlienPrefs_FRAMEWORKS = UIKit Foundation
AlienPrefs_LDFLAGS = -Wl,-undefined,dynamic_lookup

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
