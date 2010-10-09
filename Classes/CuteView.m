//
//  CuteView.m
//  CuteFrame
//

#import "CuteView.h"


@implementation CuteView

- (id) initWithFrame:(CGRect)frame {
    [super initWithFrame:frame];
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

- (void) changeColor {
    if (++cur>=[colors count])
        cur=0;
    [self setBackgroundColor:[colors objectAtIndex:cur]];
}

- (void) dealloc {
    [super dealloc];
    [colors release];
    free(&cur);
}

@end
