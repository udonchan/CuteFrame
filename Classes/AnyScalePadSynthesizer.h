//
//  AnyScalePadSynthesizer.h
//  CuteFrame
//


#import "ChromaticPadSynthesizer.h"

@interface AnyScalePadSynthesizer : ChromaticPadSynthesizer {
    NSMutableArray *noteTable;
}

- (id) initWithScaleArray:(NSArray *)baseTab;
- (void) createNoteTable:(NSArray *)baseTab;

@end
