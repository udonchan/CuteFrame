//
//  PentatonicPadSynthesizer.m
//  CuteFrame
//

#import "PentatonicPadSynthesizer.h"

@implementation PentatonicPadSynthesizer
- (id) init {
    [super init];
    NSArray* baseTab = [[NSArray alloc] initWithObjects:
                        [[NSNumber alloc] initWithInt:0],
                        [[NSNumber alloc] initWithInt:2],
                        [[NSNumber alloc] initWithInt:4],
                        [[NSNumber alloc] initWithInt:7],
                        [[NSNumber alloc] initWithInt:9],
                        nil];
    [self createNoteTable:baseTab];
    [baseTab release];
    return self;
}

@end
