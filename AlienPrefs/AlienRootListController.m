#import <UIKit/UIKit.h>

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
