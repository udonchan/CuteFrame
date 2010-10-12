//
//  PadSynthesizer.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import <UIKit/UIResponder.h>
#import <QuartzCore/QuartzCore.h>
#import "RemoteOutput.h"

@interface PadSynthesizer : UIResponder {
    RemoteOutput *ro;
    NSUserDefaults *setting;
    int max_note, min_note, max_freq, min_freq;
}

@property(assign) int max_note, min_note, max_freq, min_freq;

- (int) note2freq:(int)note_number;
- (void) changeFreq:(int) p;
- (void) changeFactor:(int) p;
- (void) setPointX:(int)x andY:(int)y;
- (void) play;
- (void) stop;

@end
