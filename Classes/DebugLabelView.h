//
//  DebugLabelView.h
//  CuteFrame
//

#import <UIKit/UIKit.h>
#import "PadSynthesizer.h"

@interface DebugLabelView : UILabel {
    NSString *format;
}

- (id) initWith:(PadSynthesizer *)p andSetting:(NSUserDefaults *)s;

@end
