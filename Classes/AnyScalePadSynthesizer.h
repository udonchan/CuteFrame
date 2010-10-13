//
//  AnyScalePadSynthesizer.h
//  CuteFrame
//


#import "ChromaticPadSynthesizer.h"

@interface AnyScalePadSynthesizer : ChromaticPadSynthesizer {
    NSMutableArray *noteTable;
}

- (void) createNoteTable:(NSArray *)baseTab;

@end
