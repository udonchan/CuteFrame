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
    int isPortamento;
} CuteWaveDef;

@interface RemoteOutput : NSObject {
    AudioUnit audioUnit;    
    BOOL isPlaying;
    int isPortamento;
    CuteWaveDef cuteWaveDef;
}

@property(nonatomic) double frequency;
@property(nonatomic) double factor;
@property(assign) int isPortamento;

-(void)play;
-(void)stop;
- (void)prepareAudioUnit;
@end