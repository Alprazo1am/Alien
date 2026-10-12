#import <UIKit/UIKit.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.alplazo1am.alien.plist"

static BOOL isEnabled() {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH];
    if (prefs && prefs[@"enabled"] != nil) {
        return [prefs[@"enabled"] boolValue];
    }
    return YES;
}

// Declare the private Notification Center date view
@interface CSNotificationCenterDateView : UIView
- (void)setDate:(NSDate *)date;
- (void)setDateText:(NSString *)text;
@end

%hook CSNotificationCenterDateView

- (void)setDate:(NSDate *)date {
    %orig(date);
    if (!isEnabled()) return;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, MMMM d"; // "Thursday, December 16"
    NSString *fullDate = [formatter stringFromDate:date];

    // Try the direct text setter first
    if ([self respondsToSelector:@selector(setDateText:)]) {
        [self performSelector:@selector(setDateText:) withObject:fullDate];
    }
}

%end
