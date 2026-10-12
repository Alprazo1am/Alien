#import <UIKit/UIKit.h>

// Preference path
#define PLIST_PATH @"/var/mobile/Library/Preferences/com.alplazo1am.alien.plist"

// Helper to read the toggle state
static BOOL isEnabled() {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH];
    if (prefs && prefs[@"enabled"] != nil) {
        return [prefs[@"enabled"] boolValue];
    }
    return YES; // Default to enabled
}

// Declare the StandBy date view controller (private class)
@interface CSStandbyDateViewController : UIViewController
- (void)setDate:(NSDate *)date;
- (void)setDateText:(NSString *)text;
@end

%hook CSStandbyDateViewController

- (void)setDate:(NSDate *)date {
    %orig(date);
    if (!isEnabled()) return;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, MMMM d"; // "Thursday, December 16"
    NSString *fullDate = [formatter stringFromDate:date];

    if ([self respondsToSelector:@selector(setDateText:)]) {
        [self performSelector:@selector(setDateText:) withObject:fullDate];
    }
}

%end
