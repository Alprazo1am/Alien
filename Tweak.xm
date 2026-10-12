#import <UIKit/UIKit.h>

#define PLIST_PATH @"/var/jb/var/mobile/Library/Preferences/com.alplazo1am.alien.plist"

static BOOL isEnabled() {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH];
    if (prefs && prefs[@"enabled"] != nil) {
        return [prefs[@"enabled"] boolValue];
    }
    return YES;
}

// Declare the class we're hooking (confirmed from ClockCustomizer)
@interface CSProminentSubtitleDateView : UIView
@end

%hook CSProminentSubtitleDateView

- (void)didMoveToWindow {
    %orig;
    if (!isEnabled()) return;

    // Get the internal text label (same ivar ClockCustomizer uses)
    UILabel *textLabel = nil;
    @try {
        textLabel = [self valueForKey:@"_textLabel"];
    } @catch (__unused NSException *e) {
        return;
    }

    if (!textLabel) return;

    // Build the full date string ("Thursday, December 16")
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, MMMM d";
    NSString *fullDate = [formatter stringFromDate:[NSDate date]];

    // Replace the abbreviated text with the full date
    textLabel.text = fullDate;

    // Keep it updated every minute
    static char kTimerKey;
    NSTimer *existing = objc_getAssociatedObject(self, &kTimerKey);
    [existing invalidate];

    __weak typeof(self) weakSelf = self;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60.0 repeats:YES block:^(NSTimer *t) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) { [t invalidate]; return; }
        UILabel *label = nil;
        @try { label = [strongSelf valueForKey:@"_textLabel"]; } @catch (__unused NSException *e) {}
        if (label) {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            df.dateFormat = @"EEEE, MMMM d";
            label.text = [df stringFromDate:[NSDate date]];
        }
    }];
    objc_setAssociatedObject(self, &kTimerKey, timer, OBJC_ASSOCIATION_RETAIN);
}

%end
