#import <UIKit/UIKit.h>

// Declare the private class and its methods so the compiler knows what we're calling.
@interface SBFLockScreenDateView : UIView
- (void)setUseCompactDateFormat:(BOOL)flag;
- (void)setDate:(NSDate *)date;
- (void)setDateText:(NSString *)text;
@end

%hook SBFLockScreenDateView

// Force the non-compact format flag to NO so the month is not abbreviated.
- (void)setUseCompactDateFormat:(BOOL)arg1 {
    %orig(NO);
}

// Fallback: override the date text directly in case the flag is ignored.
- (void)setDate:(NSDate *)date {
    %orig(date);

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, MMMM d"; // "Monday, October 12"
    NSString *fullDate = [formatter stringFromDate:date];

    [self setDateText:fullDate];
}

%end
