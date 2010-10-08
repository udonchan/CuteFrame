//
//  RemoteOutput.h
//  RemoteIO
//

#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>

typedef struct CuteWaveDef {
    double phase;
    Float64 sampleRate;
    double frequency;
    double freqz;
    double factor;
} CuteWaveDef;

@interface RemoteOutput : NSObject {
    AudioUnit audioUnit;    
    BOOL isPlaying;
    CuteWaveDef cuteWaveDef;
}

@property(nonatomic) double frequency;
@property(nonatomic) double factor;

-(void)play;
-(void)stop;
- (void)prepareAudioUnit;
@end