//
//  ChromaticPadSynthesizer.m
//  CuteFrame
//

#import "ChromaticPadSynthesizer.h"

@implementation ChromaticPadSynthesizer

- (int) point2note:(int) p {
    return (int)floor((480.0-p)/480 * (max_note - min_note)) + min_note;
}

- (void)setPointX:(int)x andY:(int)y{
    [self changeFactor:x];
    [self changeFreq:[self note2freq:current_note = [self point2note:y]]];
}

@end
