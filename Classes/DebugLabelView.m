//
//  DebugLabelView.m
//  CuteFrame
//

#import "DebugLabelView.h"

@implementation DebugLabelView

- (id) initWith:(PadSynthesizer *)p andSetting:(NSUserDefaults *)s{
    format = @"DEBUG\n"
    "max_note\t : %d \t"
    "max_freq\t : %d \n"
    "min_note\t : %d \t"
    "min_freq\t : %d \n"
    "scale_mode\t : %d";
    UIFont *font = [UIFont systemFontOfSize:12];
    self = [self initWithFrame:CGRectMake(0, 0, 320, [[NSString stringWithFormat:@"%@\n", format]
                                                      sizeWithFont:font
                                                      constrainedToSize:CGSizeMake(320, 2000) 
                                                      lineBreakMode:UILineBreakModeWordWrap].height
                                          )];
    [self setText:[NSString stringWithFormat:format, 
                   p.max_note,
                   p.max_freq,
                   p.min_note,
                   p.min_freq,
                   [[s stringForKey:@"scale"] intValue]]];
    [self setFont:font];
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.55]];
    [self setTextColor:[UIColor whiteColor]];
    [self setNumberOfLines:0];
    [self setLineBreakMode:UILineBreakModeWordWrap];
    return self;
}

- (void) dealloc {
    [super dealloc];
    [format release];
}

@end
