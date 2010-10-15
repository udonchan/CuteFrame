//
//  AbstractLFO.m
//  CuteFrame
//

#import "AbstractLFO.h"

@implementation AbstractLFO 
@synthesize delegate, frequency;

- (void) refresh {
    cur += REFRESH_RATE * frequency;
    if (delegate != nil)
        [delegate changed_LFO_value:[self wavFunc:(cur * M_PI)]];
}

- (double) wavFunc:(float)f {
#ifdef DEBUG
    NSAssert(0, @"YOU MUST IMMPLIMENT wavFunc FUNCTION");
#endif
    return 0.0;
}

- (id)init {
    self = [super init];
    cur = 0.0;
    frequency = 1.0;
    timer = [NSTimer scheduledTimerWithTimeInterval:(REFRESH_RATE) target:self
                                           selector:@selector(refresh)
                                           userInfo:nil
                                            repeats:YES];
    return self;
}

@end
