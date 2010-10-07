//
//  FrontViewController.m
//  CuteFrame
//

#import "FrontViewController.h"
@implementation FrontViewController

- (void)loadView {
    [super loadView];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [v setBackgroundColor:[UIColor whiteColor]];
    [self setView:v];
}

- (id) init {
	self = [super init];
	self.title = @"CuteFrame";
	return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
