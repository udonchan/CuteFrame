//
//  PadSynthesizer.m
//  CuteFrame
//

#import "PadSynthesizer.h"

@implementation PadSynthesizer
@synthesize max_note, min_note, max_freq, min_freq, ro, current_note;

-(id) init {
    [super init];
    setting = [NSUserDefaults standardUserDefaults];
    ro = [[RemoteOutput alloc] init];
    ro.isPortamento = [[setting stringForKey:@"isPortamento"] intValue];
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"useAccelerometer"] boolValue]){
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        accelerometer.updateInterval = 1.0 / 60.0;
        accelerometer.delegate = ro;
    }
    max_note = (int)[[setting stringForKey:@"max_note"] floatValue];
    min_note = (int)[[setting stringForKey:@"min_note"] floatValue];
    if (max_note < 40 || 127 < max_note) max_note = 127;
    if (min_note < 40 || 127 < min_note) min_note = 40;
    if (max_note < min_note) min_note = max_note;
    max_freq = [self note2freq:max_note];
    min_freq = [self note2freq:min_note];
    current_note = -1;
    return self;
}    

- (void) dealloc {
    [super dealloc];
    [ro release];
}

- (void) changeFreq:(double) freq {
    ro.frequency = freq;
}

- (double) genFreq:(int) p {
    return pow((480.0-p)/480, 2) * (max_freq - min_freq) + min_freq;
}

- (void) changeFactor:(int) p {
    ro.factor = (double)p/320;
}

- (int) note2freq:(int)note_number {
    return (int)(pow(2, ((float)note_number - 69) / 12) * 440);
}

- (void)setPointX:(int)x andY:(int)y {
    [self changeFreq:[self genFreq:y]];
    [self changeFactor:x];
}

- (void) play{
    [ro play];
}

- (void) stop{
    [ro stop];
}

@end
