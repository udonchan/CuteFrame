//
//  ChromaticPadSynthesizer.m
//  CuteFrame
//

#import "ChromaticPadSynthesizer.h"

@implementation ChromaticPadSynthesizer

- (void) changeFreq:(int) p {
    ro.frequency = [self note2freq:(int)floor((480.0-p)/480 * (max_note - min_note)) + min_note];
}

@end
