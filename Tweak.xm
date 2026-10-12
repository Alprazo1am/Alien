#import <UIKit/UIKit.h>

%hook SBFLockScreenDateView

// Force the non-compact format flag to NO so the month is not abbreviated.
// The header for SBFLockScreenDateView confirms a BOOL property
// called _useCompactDateFormat (and its setter) exists on this class.
- (void)setUseCompactDateFormat:(BOOL)arg1 {
    %orig(NO);
}

// Fallback: override the date text directly in case the flag is ignored.
- (void)setDate:(NSDate *)date {
    %orig(date);

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, MMMM d"; // "Monday, October 12"
    NSString *fullDate = [formatter stringFromDate:date];

    if ([self respondsToSelector:@selector(setDateText:)]) {
        [self performSelector:@selector(setDateText:) withObject:fullDate];
    }
}

%end
