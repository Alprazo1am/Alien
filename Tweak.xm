#import <UIKit/UIKit.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.alplazo1am.alien.plist"

static BOOL isEnabled() {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH];
    if (prefs && prefs[@"enabled"] != nil) {
        return [prefs[@"enabled"] boolValue];
    }
    return YES;
}

// Hook NSDateFormatter to intercept the date string generation
%hook NSDateFormatter

- (NSString *)stringFromDate:(NSDate *)date {
    NSString *original = %orig(date);
    if (!isEnabled()) return original;

    // Only apply to short date formats that produce abbreviated months
    NSString *format = [self dateFormat];
    if ([format containsString:@"MMM"] && ![format containsString:@"MMMM"]) {
        // Check if this is likely the Notification Center date
        // by looking at the current thread's call stack context
        NSArray *callStack = [NSThread callStackSymbols];
        for (NSString *symbol in callStack) {
            if ([symbol containsString:@"NotificationCenter"] ||
                [symbol containsString:@"CoverSheet"] ||
                [symbol containsString:@"CSNotification"]) {
                NSDateFormatter *fullFormatter = [[NSDateFormatter alloc] init];
                fullFormatter.dateFormat = @"EEEE, MMMM d";
                return [fullFormatter stringFromDate:date];
            }
        }
    }
    return original;
}

%end
