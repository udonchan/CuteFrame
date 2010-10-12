//
//  FrontViewController.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RemoteOutput.h"
#import "CuteView.h"
#import "PadSynthesizer.h"
#import "ChromaticPadSynthesizer.h"

#define SCALE_NONE 0
#define SCALE_CHROMATIC 1

@interface FrontViewController : UIViewController {
    CuteView *v;
    NSTimer *timer; 
    BOOL isTouch;
    NSUserDefaults *setting;
    PadSynthesizer *ps;
}

- (void) changeColor;
@end
