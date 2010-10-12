//
//  FrontViewController.m
//  CuteFrame
//

#import "FrontViewController.h"

@implementation FrontViewController

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:v];
    isTouch = YES;
    [ps setPointX:location.x andY:location.y];
    [ps play];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[touches anyObject] locationInView:v];
    [ps setPointX:location.x andY:location.y];

}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    if ([[event allTouches] count] <= 1) {
        isTouch = NO;
        [ps stop];
        [v setBackgroundColor:[UIColor blackColor]];
    } else {
        [ps setPointX:[[[event touchesForView:v] anyObject] locationInView:v].x 
                 andY:[[[event touchesForView:v] anyObject] locationInView:v].y];
    }
}

- (void) changeColor {
    if (isTouch) [v changeColor];
}

- (void)loadView {
    [super loadView];
    v = [[CuteView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [v setMultipleTouchEnabled:YES];
    [v setBackgroundColor:[UIColor blackColor]];
#ifdef DEBUG
    dlv = [[DebugLabelView alloc] initWith:ps andSetting:setting];
    [v addSubview:dlv];
#endif

    [self setView:v];
}

- (id) init {
	self = [super init];
    setting = [NSUserDefaults standardUserDefaults];
    if ([[setting stringForKey:@"scale"]intValue] == SCALE_CHROMATIC)
        ps = [[ChromaticPadSynthesizer alloc] init];
    else
        ps = [[PadSynthesizer alloc] init];
	return self;
}

- (void)viewWillAppear:(BOOL)animated {	
    timer = [NSTimer scheduledTimerWithTimeInterval:(0.01) target:self
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
    [setting release];
    [v release];
}


@end
