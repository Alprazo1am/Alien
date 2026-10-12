ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:17.0
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = AlienPrefs
AlienPrefs_FILES = AlienRootListController.m
AlienPrefs_CFLAGS = -fobjc-arc
AlienPrefs_INSTALL_PATH = /Library/PreferenceBundles
AlienPrefs_FRAMEWORKS = UIKit
AlienPrefs_LDFLAGS = -Wl,-undefined,dynamic_lookup

include $(THEOS_MAKE_PATH)/bundle.mk
