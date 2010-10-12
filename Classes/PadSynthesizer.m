//
//  PadSynthesizer.m
//  CuteFrame
//

#import "PadSynthesizer.h"

@implementation PadSynthesizer
@synthesize max_note, min_note, max_freq, min_freq;

-(id) init {
    [super init];
    ro = [[RemoteOutput alloc] init];
    setting = [NSUserDefaults standardUserDefaults];
    max_note = (int)[[setting stringForKey:@"max_note"] floatValue];
    min_note = (int)[[setting stringForKey:@"min_note"] floatValue];
    if (max_note < 40 || 127 < max_note) max_note = 127;
    if (min_note < 40 || 127 < min_note) min_note = 40;
    if (max_note < min_note) min_note = max_note;
    max_freq = [self note2freq:max_note];
    min_freq = [self note2freq:min_note];
    return self;
}    

- (void) dealloc {
    [super dealloc];
    [ro release];
    [setting release];
}

- (void) changeFreq:(int) p {
    ro.frequency = pow((480.0-p)/480, 2) * (max_freq - min_freq) + min_freq;
}

- (void) changeFactor:(int) p {
    ro.factor = (double)p/320;
}

- (int) note2freq:(int)note_number {
    return (int)(pow(2, ((float)note_number - 69) / 12) * 440);
}

- (void)setPointX:(int)x andY:(int)y {
    [self changeFreq:y];
    [self changeFactor:x];
}

- (void) play{
    [ro play];
}

- (void) stop{
    [ro stop];
}

@end
