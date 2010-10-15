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
    double value;
    id<LFODelegate> delegate;
}
@property (assign, readonly) double value;
@property (assign) double frequency;
@property (assign) id<LFODelegate> delegate;

- (double) wavFunc:(float)f ;

@end
