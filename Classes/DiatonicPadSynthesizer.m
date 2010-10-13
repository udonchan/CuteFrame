//
//  DiatonicPadSynthesizer.m
//  CuteFrame
//

#import "DiatonicPadSynthesizer.h"

@implementation DiatonicPadSynthesizer

- (void) createNoteTable {
    noteTable = [[NSMutableArray alloc] init];
    int baseKeyTab[7] = {0, 2, 4, 5, 7, 9, 11};    
    int key = [[[NSUserDefaults standardUserDefaults] stringForKey:@"key"]intValue];
    for (int cur = min_note; cur <= max_note; cur++) {
        for(int i = 0; i < 7; i++) {
            if ((cur-key)%12 == baseKeyTab[i]){
                [noteTable addObject:[[NSNumber alloc]initWithInt:cur]];
                break;
            }
        }
    }
}    
    
- (int) point2note:(int) p {
    return [[noteTable objectAtIndex:(int)((480.0-p)/480 * [noteTable count])]intValue];
}

- (id) init {
    [super init];
    [self createNoteTable];
    return self;
}

- (void) dealloc {
    [super dealloc];
    [noteTable release];
}

@end
