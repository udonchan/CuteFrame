//
//  AbstractLFO.h
//  CuteFrame
//

#import "LFODelegate.h"
#define REFRESH_RATE (1.0 / 60)

@interface AbstractLFO : NSObject {
    NSTimer *timer;
    double frequency;
    double cur;
    id<LFODelegate> delegate;
}
@property (assign) double frequency;
@property (assign) id<LFODelegate> delegate;

- (double) wavFunc:(float)f ;

@end
