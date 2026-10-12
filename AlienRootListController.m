#import <UIKit/UIKit.h>

// Declare PSListController manually since we can't link against Preferences.
@interface PSListController : UIViewController
- (id)loadSpecifiersFromPlistName:(NSString *)name target:(id)target;
@end

@interface AlienRootListController : PSListController
@end

@implementation AlienRootListController

- (NSArray *)specifiers {
    return [self loadSpecifiersFromPlistName:@"Root" target:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Alien";
}

@end
