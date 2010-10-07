//
//  CuteFrameAppDelegate.m
//  CuteFrame
//

#import "CuteFrameAppDelegate.h"

@implementation CuteFrameAppDelegate
@synthesize f, w;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    f = [[FrontViewController alloc] init];
    w = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [w makeKeyAndVisible];
    [w addSubview:f.view];
	return YES;
}
-(void)dealloc {
    [f release];
    [w release];
    [super dealloc];
}
@end
