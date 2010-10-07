//
//  CuteFrameAppDelegate.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import "FrontViewController.h"

@interface CuteFrameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *w;
    FrontViewController *f;
}

@property (nonatomic, retain) UIWindow *w;
@property (nonatomic, retain) FrontViewController *f;

@end

