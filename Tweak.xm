#import <UIKit/UIKit.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.alplazo1am.alien.plist"

static BOOL isEnabled() {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH];
    if (prefs && prefs[@"enabled"] != nil) {
        return [prefs[@"enabled"] boolValue];
    }
    return YES;
}

%hook NSDateFormatter

- (void)setDateFormat:(NSString *)format {
    if (isEnabled()) {
        // iOS uses "EEE, MMM d" for the abbreviated NC date.
        // Swap it to "EEEE, MMMM d" for the full version.
        if ([format isEqualToString:@"EEE, MMM d"]) {
            format = @"EEEE, MMMM d";
        }
        // Cover a couple of minor variants just in case
        else if ([format isEqualToString:@"EEE MMM d"]) {
            format = @"EEEE MMMM d";
        }
    }
    %orig(format);
}

%end
