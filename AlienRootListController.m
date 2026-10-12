#import <UIKit/UIKit.h>

// Declare PSListController manually since we can't link against Preferences.
@interface PSListController : UIViewController
- (NSArray *)specifiers;
- (id)loadSpecifiersFromPlistName:(NSString *)name target:(id)target;
@end

@interface AlienRootListController : PSListController
@end

@implementation AlienRootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }
    return _specifiers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Alien";
}

@end
