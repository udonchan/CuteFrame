//
//  FrontViewController.m
//  CuteFrame
//

#import "FrontViewController.h"
@implementation FrontViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:v];
    CALayer *hitLayer = [[v layer] hitTest:location];
    if (hitLayer == v.layer) {
        isTouch = YES;
        [self changeFreq:location.y];
        [self changeFactor:location.x];
        [ro play];
    }

}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:v];
    CALayer *hitLayer = [[v layer] hitTest:location];
    if (hitLayer == v.layer) {
        [self changeFreq:location.y];
        [self changeFactor:location.x];
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint location = [[touches anyObject] locationInView:v];
    CALayer *hitLayer = [[v layer] hitTest:location];
    if (hitLayer == v.layer) {
        isTouch = NO;
        [ro stop];
    }
}

- (void) changeFreq:(int) y {
    ro.frequency = pow((480.0-y)/480, 2)*(MAX_FREQ-MIN_FREQ)+MIN_FREQ;
}

- (void) changeFactor:(int) x {
    ro.factor = (double)x/320;
}

- (void) changeColor {
    if (!isTouch) return;
    if (++cur>=[colors count])
        cur=0;
    [v setBackgroundColor:[colors objectAtIndex:cur]];
}

- (void)loadView {
    [super loadView];
    v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [v setBackgroundColor:[colors objectAtIndex:0]];
    [self setView:v];
}

- (id) init {
	self = [super init];
	self.title = @"CuteFrame";
    colors = [[NSArray alloc] initWithObjects:
               [UIColor redColor],
               [UIColor greenColor],
               [UIColor blueColor],
               [UIColor yellowColor],
               [UIColor purpleColor],
               [UIColor magentaColor],
               [UIColor cyanColor],nil];
    ro = [[RemoteOutput alloc] init];
	return self;
}

- (void)viewWillAppear:(BOOL)animated {	
    timer = [NSTimer scheduledTimerWithTimeInterval:(0.01) 
                                                 target:self
                                               selector:@selector(changeColor)
                                               userInfo:nil
                                                repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)dealloc {
    [super dealloc];
    [v release];
    [ro release];
}


@end
