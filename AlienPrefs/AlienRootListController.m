#import <Preferences/PSListController.h>

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
