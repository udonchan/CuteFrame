//
//  PadSynthesizer.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RemoteOutput.h"

@interface PadSynthesizer : NSObject {
    RemoteOutput *ro;
    NSUserDefaults *setting;
    int max_note, min_note, max_freq, min_freq;
    int current_note;
}

@property(assign, readonly) int max_note, min_note, max_freq, min_freq, current_note;
@property(retain, readonly) RemoteOutput *ro;

- (int) note2freq:(int)note_number;
- (void) changeFreq:(double) freq;
- (double) genFreq:(int) p;
- (void) changeFactor:(int) p;
- (void) setPointX:(int)x andY:(int)y;
- (void) play;
- (void) stop;

@end
