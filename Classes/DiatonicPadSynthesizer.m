//
//  DiatonicPadSynthesizer.m
//  CuteFrame
//

#import "DiatonicPadSynthesizer.h"

@implementation DiatonicPadSynthesizer

- (id) init {
    [super init];
    NSArray* baseTab = [[NSArray alloc] initWithObjects:
                        [[NSNumber alloc] initWithInt:0],
                        [[NSNumber alloc] initWithInt:2],
                        [[NSNumber alloc] initWithInt:4],
                        [[NSNumber alloc] initWithInt:5],
                        [[NSNumber alloc] initWithInt:7],
                        [[NSNumber alloc] initWithInt:9],
                        [[NSNumber alloc] initWithInt:11],
                        nil];
    [self createNoteTable:baseTab];
    [baseTab release];
    return self;
}

@end
