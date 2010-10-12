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
    if (!isTouch) return;
    [v changeColor];
}

- (void)loadView {
    [super loadView];
    v = [[CuteView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [v setMultipleTouchEnabled:YES];
    [v setBackgroundColor:[UIColor blackColor]];

#ifdef DEBUG
    NSString *str = [NSString stringWithFormat:@"DEBUG\n"
                     "max_note\t : %d \n"
                     "min_note\t : %d \n"
                     "max_freq\t : %d \n"
                     "min_freq\t : %d \n"
                     "scale_mode\t : %d",
                     ps.max_note, ps.min_note, ps.max_freq, ps.min_freq, [[setting stringForKey:@"scale"]intValue]];
    UIFont *font = [UIFont systemFontOfSize:12];
    UILabel *debugStr = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, [str sizeWithFont:font
                                                                             constrainedToSize:CGSizeMake(320, 2000) 
                                                                                 lineBreakMode:UILineBreakModeWordWrap].height
                                                                  )];
    [debugStr setFont:font];
    [debugStr setBackgroundColor:[UIColor blackColor]];
    [debugStr setTextColor:[UIColor whiteColor]];
    [debugStr setNumberOfLines:0];
    [debugStr setLineBreakMode:UILineBreakModeWordWrap];
    [debugStr setText:str];
    [v addSubview:debugStr];
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
