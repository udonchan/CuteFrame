//
//  RemoteOutput.m
//  RemoteIO
//

#import "RemoteOutput.h"

@implementation RemoteOutput
@synthesize lfo;

static OSStatus renderCallback(void*                       inRefCon,
                               AudioUnitRenderActionFlags* ioActionFlags,
                               const AudioTimeStamp*       inTimeStamp,
                               UInt32                      inBusNumber,
                               UInt32                      inNumberFrames,
                               AudioBufferList*            ioData){
    CuteWaveDef* def = (CuteWaveDef*)inRefCon;
    
    double freqz = def->freqz;
    double freq = def->frequency;
    double phase = def->phase;
    double factor = def->factor;
    AudioUnitSampleType *outL = ioData->mBuffers[0].mData;
    AudioUnitSampleType *outR = ioData->mBuffers[1].mData;
    
    for(int i = 0; i< inNumberFrames; i++){
        float wave = sin(phase) * (1 - factor) + (cos(phase) > 0 ? 1.0 : -1.0) * factor / 2;
        AudioUnitSampleType sample = wave * (1 << kAudioUnitSampleFractionBits);
        *outL++ = sample;
        *outR++ = sample;
        phase = phase + freqz;
        if (def->isPortamento)
            freqz = 0.001 * freq + 0.999 * freqz;
        else freqz= freq;
    }
    def->freqz = freqz;
    def->phase = phase;
    return noErr;
}

- (void) changed_LFO_value:(double)_v {
    cuteWaveDef.frequency = (_frequency + _v * vib_rate * _frequency) * 2.0 * M_PI / cuteWaveDef.sampleRate;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer 
        didAccelerate:(UIAcceleration *)acceleration{
    vib_rate = default_vib_rate * (acceleration.y > 0 ? acceleration.y : -acceleration.y);
    lfo.frequency = [[[NSUserDefaults standardUserDefaults] stringForKey:@"vib_freq"] floatValue] * (acceleration.x + 1.0) / 2 ;
}

- (id)init{
    self = [super init];
    if (self != nil)[self prepareAudioUnit];
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"isVibrato"] boolValue]) {
        switch ([[[NSUserDefaults standardUserDefaults] stringForKey:@"lfo_type"] intValue]) {
            case 1:
                lfo = [[SquareWaveLFO alloc] init];
                break;
            case 2:
                lfo = [[RandomLFO alloc] init];
                break;
            default:
                lfo = [[SineWaveLFO alloc] init];
                break;
        }
        lfo.delegate = self;
        lfo.frequency = [[[NSUserDefaults standardUserDefaults] stringForKey:@"vib_freq"] floatValue];
        default_vib_rate = vib_rate = [[[NSUserDefaults standardUserDefaults] stringForKey:@"vib_rate"] floatValue] / 1000;
    }
    return self;
}

-(BOOL)isPlaying{
    return isPlaying;
}

- (double) currentFrequency {
    return cuteWaveDef.frequency / (2.0 * M_PI) * cuteWaveDef.sampleRate;
}

- (double)frequency {
    return _frequency;
}

-(void)setFrequency:(double)frequency{
    _frequency = frequency;
    cuteWaveDef.frequency = _frequency * 2.0 * M_PI / cuteWaveDef.sampleRate;
}

-(double)factor{
    return cuteWaveDef.factor;
}

-(void)setFactor:(double)factor{
    cuteWaveDef.factor = factor;
}

- (int) isPortamento {
    return isPortamento;
}

-(void)setIsPortamento:(int) i{
    cuteWaveDef.isPortamento = i;
}

- (void)prepareAudioUnit{
    AudioComponentDescription cd;
    cd.componentType = kAudioUnitType_Output;
    cd.componentSubType = kAudioUnitSubType_RemoteIO;
    cd.componentManufacturer = kAudioUnitManufacturer_Apple;
    cd.componentFlags = 0;
    cd.componentFlagsMask = 0;
    AudioComponentInstanceNew(AudioComponentFindNext(NULL, &cd), &audioUnit);
    AudioUnitInitialize(audioUnit);
    AURenderCallbackStruct callbackStruct;
    callbackStruct.inputProc = renderCallback;
    callbackStruct.inputProcRefCon = &cuteWaveDef;
    AudioUnitSetProperty(audioUnit, 
                         kAudioUnitProperty_SetRenderCallback, 
                         kAudioUnitScope_Input,
                         0,
                         &callbackStruct,
                         sizeof(AURenderCallbackStruct));
    cuteWaveDef.sampleRate = 44100.0;
    cuteWaveDef.phase = 0.0;
    cuteWaveDef.factor = 0.0;
    [self setFrequency:440];
    cuteWaveDef.freqz = cuteWaveDef.freqz;
    AudioStreamBasicDescription audioFormat = AUCanonicalASBD(cuteWaveDef.sampleRate, 2);
    AudioUnitSetProperty(audioUnit,
                         kAudioUnitProperty_StreamFormat,
                         kAudioUnitScope_Input,
                         0,
                         &audioFormat,
                         sizeof(audioFormat));

    AudioSessionInitialize(NULL, NULL, NULL,NULL);
    Float32 duration = 128 / cuteWaveDef.sampleRate;
    AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareIOBufferDuration, 
                            sizeof(Float32),
                            &duration);
    
}

-(void)play{
    if(!isPlaying)AudioOutputUnitStart(audioUnit);
    isPlaying = YES;
}

-(void)stop{
    if(isPlaying)AudioOutputUnitStop(audioUnit);
    isPlaying = NO;
}

- (void)dealloc{
    if(isPlaying)AudioOutputUnitStop(audioUnit);
    AudioUnitUninitialize(audioUnit);
    AudioComponentInstanceDispose(audioUnit);
    [super dealloc];
}

@end