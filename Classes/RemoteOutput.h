//
//  RemoteOutput.h
//  RemoteIO
//

#import <UIKit/UIKit.h>
#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "iPhoneCoreAudio.h";
#import "SineWaveLFO.h"
#import "SquareWaveLFO.h"
#import "RandomLFO.h"

typedef struct CuteWaveDef {
    double phase;
    Float64 sampleRate;
    double frequency;
    double freqz;
    double factor;
    int isPortamento;
} CuteWaveDef;

@interface RemoteOutput : NSObject <UIAccelerometerDelegate, LFODelegate>{
    AudioUnit audioUnit;    
    BOOL isPlaying;
    int isPortamento;
    CuteWaveDef cuteWaveDef;
    AbstractLFO *lfo;
    double _frequency;
    double default_vib_rate;
    double vib_rate;
}

@property (nonatomic, retain, readonly) AbstractLFO *lfo;
@property (nonatomic) double frequency;
@property (nonatomic) double factor;
@property (assign) int isPortamento;

- (double) currentFrequency;
- (void) changed_LFO_value:(double)_v;
- (void) play;
- (void) stop;
- (void) prepareAudioUnit;
@end