//
//  SquareWaveLFO.m
//  CuteFrame
//

#import "SquareWaveLFO.h"

@implementation SquareWaveLFO

- (double)wavFunc:(float)f {
    return sin(f) > 0 ? 1.0 : -1.0;
}
@end
