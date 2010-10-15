//
//  DebugLabelView.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import "PadSynthesizer.h"

@interface DebugLabelView : UILabel {
    PadSynthesizer *_p;
    NSUserDefaults *_s;
    NSString *format;
    UIView *lfo_view;
}

- (void) updateLabel;
- (id) initWith:(PadSynthesizer *)p andSetting:(NSUserDefaults *)s;

@end
