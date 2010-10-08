//
//  RemoteOutput.h
//  RemoteIO
//

#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>

typedef struct SineWaveDef {
    double phase;
    Float64 sampleRate;
    double frequency;
    double freqz;
} SineWaveDef;

@interface RemoteOutput : NSObject {
    AudioUnit audioUnit;    
    BOOL isPlaying;
    SineWaveDef sineWaveDef;
}

@property(nonatomic) double frequency;

-(void)play;
-(void)stop;
- (void)prepareAudioUnit;
@end