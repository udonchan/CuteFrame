//
//  CuteFrameAppDelegate.m
//  CuteFrame
//

#import "CuteFrameAppDelegate.h"

@implementation CuteFrameAppDelegate
@synthesize window;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [window makeKeyAndVisible];
	return YES;
}
-(void)dealloc {
    [window release];
    [super dealloc];
}
@end
