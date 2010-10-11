//
//  FrontViewController.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RemoteOutput.h"
#import "CuteView.h"

#define SCALE_NONE 0
#define SCALE_CHROMATIC 1

@interface FrontViewController : UIViewController {
    RemoteOutput *ro;
    CuteView *v;
    NSTimer *timer; 
    BOOL isTouch;
    NSUserDefaults *setting;
    int max, min, max_freq, min_freq;
    int mode;
}

- (void) changeFreq:(int) y;
- (void) changeFactor:(int) x;
- (void) changeColor;
- (int) note2freq:(int)note_number;
@end
