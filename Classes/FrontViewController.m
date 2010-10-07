//
//  FrontViewController.m
//  CuteFrame
//

#import "FrontViewController.h"
@implementation FrontViewController

- (void) changeColor {
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
	return self;
}

- (void)viewWillAppear:(BOOL)animated {	
    timer = [NSTimer scheduledTimerWithTimeInterval:(0.05) 
                                                 target:self
                                               selector:@selector(changeColor)
                                               userInfo:nil
                                                repeats:YES];
}

- (void)dealloc {
    [super dealloc];
    [timer invalidate];
    [v release];
}


@end
