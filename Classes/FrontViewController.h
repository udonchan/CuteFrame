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
#import "AnyScalePadSynthesizer.h"
#import "ScaleArrays.h"
#import "DebugLabelView.h"

#define SCALE_NONE       0
#define SCALE_CHROMATIC  1
#define SCALE_DIATONIC   2
#define SCALE_PENTATONIC 3

@interface FrontViewController : UIViewController {
    CuteView *v;
    NSTimer *timer; 
    BOOL isTouch;
    NSUserDefaults *setting;
    PadSynthesizer *ps;
#ifdef DEBUG
    DebugLabelView *dlv;
#endif
}

- (void) changeColor;
@end
