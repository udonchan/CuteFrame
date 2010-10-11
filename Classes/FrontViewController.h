//
//  FrontViewController.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RemoteOutput.h"
#import "CuteView.h"

@interface FrontViewController : UIViewController {
    RemoteOutput *ro;
    CuteView *v;
    NSTimer *timer; 
    BOOL isTouch;
    NSUserDefaults *setting;
    int max, min;
}

- (void) changeFreq:(int) y;
- (void) changeFactor:(int) x;
- (void) changeColor;
- (int) note2freq:(int)note_number;
@end
