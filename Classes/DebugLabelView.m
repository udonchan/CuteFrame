//
//  DebugLabelView.m
//  CuteFrame
//

#import "DebugLabelView.h"

@implementation DebugLabelView

- (NSString *) scale_name:(int) i {
    switch (i) {
        case 0:
            return @"none";
        case 1:
            return @"chromatic";
        case 2:
            return @"diatonic";
        case 3:
            return @"pentatonic";
        case 4:
            return @"arabic";
        case 5:
            return @"spanish";
        default:
            return @"unkonown";
    }
}

- (NSString *) note_number2String:(int)note_number {
    if (note_number==-1) return @"nil";
    int oct = note_number/12;
    switch (note_number%12) {
        case 0:
            return [NSString stringWithFormat:@"%@(%d)", @"C ", oct];
        case 1:
            return [NSString stringWithFormat:@"%@(%d)", @"C#", oct];
        case 2:
            return [NSString stringWithFormat:@"%@(%d)", @"D ", oct];
        case 3:
            return [NSString stringWithFormat:@"%@(%d)", @"D#", oct];
        case 4:
            return [NSString stringWithFormat:@"%@(%d)", @"E ", oct];
        case 5:
            return [NSString stringWithFormat:@"%@(%d)", @"F ", oct];
        case 6:
            return [NSString stringWithFormat:@"%@(%d)", @"F#", oct];
        case 7:
            return [NSString stringWithFormat:@"%@(%d)", @"G ", oct];
        case 8:
            return [NSString stringWithFormat:@"%@(%d)", @"G#", oct];
        case 9:
            return [NSString stringWithFormat:@"%@(%d)", @"A ", oct];
        case 10:
            return [NSString stringWithFormat:@"%@(%d)", @"A#", oct];
        case 11:
            return [NSString stringWithFormat:@"%@(%d)", @"B ", oct];
        default:
            return @"";
    }
}

- (void) updateLabel {
    [self setText:[NSString stringWithFormat:format, 
                   _p.max_note,
                   _p.max_freq,
                   _p.min_note,
                   _p.min_freq,
                   [self scale_name:[[_s stringForKey:@"scale"] intValue]],
                   [[_s stringForKey:@"isPortamento"] intValue],
                   [self note_number2String:_p.current_note],
                   [_p.ro currentFrequency]
                   ]];    
}

- (id) initWith:(PadSynthesizer *)p andSetting:(NSUserDefaults *)s{
    _p = p; _s = s;
    format = @"DEBUG\n"
    "max_note : %d \t"
    "max_freq : %d \n"
    "min_note : %d \t"
    "min_freq : %d \n"
    "scale_mode\t : %@\t"
    "portament : %d\n"
    "note : %@\t"
    "freq : %lf";
    UIFont *font = [UIFont fontWithName:@"Courier new" size:12];
    self = [self initWithFrame:CGRectMake(0, 0, 320, [[NSString stringWithFormat:@"%@\n", format]
                                                      sizeWithFont:font
                                                      constrainedToSize:CGSizeMake(320, 2000) 
                                                      lineBreakMode:UILineBreakModeWordWrap].height)];
    [self updateLabel];
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
