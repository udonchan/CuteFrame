//
//  RemoteOutput.h
//  RemoteIO
//

#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SineWaveLFO.h"

typedef struct CuteWaveDef {
    double phase;
    Float64 sampleRate;
    double frequency;
    double freqz;
    double factor;
    int isPortamento;
} CuteWaveDef;

@interface RemoteOutput : NSObject <LFODelegate>{
    AudioUnit audioUnit;    
    BOOL isPlaying;
    int isPortamento;
    CuteWaveDef cuteWaveDef;
    AbstractLFO *lfo;
    double _frequency;
}

@property (nonatomic) double frequency;
@property (nonatomic) double factor;
@property (assign) int isPortamento;

- (double) currentFrequency;
- (void) changed_LFO_value:(double)_v;
- (void) play;
- (void) stop;
- (void) prepareAudioUnit;
@end