//
//  ChromaticPadSynthesizer.m
//  CuteFrame
//

#import "ChromaticPadSynthesizer.h"

@implementation ChromaticPadSynthesizer

- (int) point2note:(int) p {
    return (int)floor((480.0-p)/480 * (max_note - min_note)) + min_note;
}

- (int)setPointX:(int)x andY:(int)y{
    [self changeFactor:x];
    int note_number = [self point2note:y];
    [self changeFreq:[self note2freq:note_number]];
    return note_number;
    
}

@end
