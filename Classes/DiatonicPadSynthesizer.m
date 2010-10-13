//
//  DiatonicPadSynthesizer.m
//  CuteFrame
//

#import "DiatonicPadSynthesizer.h"

@implementation DiatonicPadSynthesizer


- (void) createNoteTable:(NSArray *)baseTab {
    noteTable = [[NSMutableArray alloc] init];
    int key = [[[NSUserDefaults standardUserDefaults] stringForKey:@"key"]intValue];
    for (int cur = min_note; cur <= max_note; cur++) {
        for(int i = 0; i < [baseTab count]; i++) {
            if ((cur-key)%12 == [[baseTab objectAtIndex:i]intValue]){
                [noteTable addObject:[[NSNumber alloc]initWithInt:cur]];
                break;
            }
        }
    }
}    
    
- (int) point2note:(int) p {
    int idx = (int)((480.0-p)/480 * [noteTable count]);
    if (idx > [noteTable count]-1) return [[noteTable lastObject]intValue];
    if (idx < 1) return [[noteTable objectAtIndex:0]intValue];
    return [[noteTable objectAtIndex:idx]intValue];
}

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

- (void) dealloc {
    [super dealloc];
    [noteTable release];
}

@end
