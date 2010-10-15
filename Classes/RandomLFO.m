//
//  RandomLFO.m
//  CuteFrame
//

#import "RandomLFO.h"


@implementation RandomLFO
- (void) refresh {
    cur += REFRESH_RATE * frequency;
    pre_freq = cur_freq;
    cur_freq = [self wavFunc:(cur * M_PI)];
    if (cur_freq != pre_freq) {
        if (delegate != nil) {
            [delegate changed_LFO_value:value = (float)(random() % 100000) / 100000  * 2.0 - 1.0];
        }
    }
}
@end
