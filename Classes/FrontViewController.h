//
//  FrontViewController.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RemoteOutput.h"

#define MIN_FREQ 60
#define MAX_FREQ 12000

@interface FrontViewController : UIViewController {
    RemoteOutput *ro;
    UIView *v;
    NSArray *colors;
    NSTimer *timer; 
    int cur;
    BOOL isTouch;
}

- (void) changeFreq:(int) y;
- (void) changeFactor:(int) x;
- (void) changeColor;
@end
