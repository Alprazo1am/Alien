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
AlienPrefs_FRAMEWORKS = UIKit
AlienPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
