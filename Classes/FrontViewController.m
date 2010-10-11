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
    if (hitLayer == v.layer && [[event touchesForView:v] count] <= 1) {
        isTouch = NO;
        [ro stop];
        [v setBackgroundColor:[UIColor blackColor]];
    } else {
        [self changeFactor:[[[event touchesForView:v] anyObject] locationInView:v].x];
        [self changeFreq:[[[event touchesForView:v] anyObject] locationInView:v].y];
    }
}

- (void) changeFreq:(int) y {
    if (mode == SCALE_NONE)
        ro.frequency = pow((480.0-y)/480, 2) * (max_freq - min_freq) + min_freq;
    else if (mode == SCALE_CHROMATIC){
        NSLog(@"%d", [self note2freq:(int)floor((480.0-y)/480 * (max - min)) + min]);
        ro.frequency = [self note2freq:(int)floor((480.0-y)/480 * (max-min)) + min];
    }
}

- (void) changeFactor:(int) x {
    ro.factor = (double)x/320;
}

- (void) changeColor {
    if (!isTouch) return;
    [v changeColor];
}

- (int) note2freq:(int)note_number {
    return (int)(pow(2, ((float)note_number - 69) / 12) * 440);
}

- (void)loadView {
    [super loadView];
    v = [[CuteView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [v setMultipleTouchEnabled:YES];
    [v setBackgroundColor:[UIColor blackColor]];
#ifdef DEBUG
    NSString *str = [NSString stringWithFormat:@"debug\nMaxFreq : %d \nMinFreq : %d",
//                    [setting stringForKey:@"max_note"], [setting stringForKey:@"min_note"]];
                      max, min];
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
	self.title = @"CuteFrame";
    ro = [[RemoteOutput alloc] init];

    setting = [NSUserDefaults standardUserDefaults];
    max = (int)[[setting stringForKey:@"max_note"] floatValue];
    min = (int)[[setting stringForKey:@"min_note"] floatValue];
    if (max < 40 || 127 < max) max = 127;
    if (min < 40 || 127 < min) min = 40;
    if (max < min) min = max;
    max_freq = [self note2freq:max];
    min_freq = [self note2freq:min];
    mode = [[setting stringForKey:@"scale"] intValue];
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
    [setting release];
    [v release];
    [ro release];
}


@end
