//
//  DiatonicPadSynthesizer.h
//  CuteFrame
//


#import "ChromaticPadSynthesizer.h"

@interface DiatonicPadSynthesizer : ChromaticPadSynthesizer {
    NSMutableArray *noteTable;
}

- (void) createNoteTable;

@end
