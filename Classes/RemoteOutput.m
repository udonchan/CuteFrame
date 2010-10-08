//
//  RemoteOutput.m
//  RemoteIO
//

#import "RemoteOutput.h"

@implementation RemoteOutput

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
        //滑らかに変化させる
        freqz = 0.001 * freq + 0.999 * freqz;
    }
    def->freqz = freqz;
    def->phase = phase;
    return noErr;
}

- (id)init{
    self = [super init];
    if (self != nil)[self prepareAudioUnit];
    return self;
}

-(BOOL)isPlaying{
    return isPlaying;
}

-(double)frequency{
    return cuteWaveDef.frequency / (2.0 * M_PI) * cuteWaveDef.sampleRate;
}

-(void)setFrequency:(double)frequency{
    cuteWaveDef.frequency = frequency * 2.0 * M_PI / cuteWaveDef.sampleRate;
}

-(double)factor{
    return cuteWaveDef.factor;
}

-(void)setFactor:(double)factor{
    cuteWaveDef.factor = factor;
}

- (void)prepareAudioUnit{
    //RemoteIO Audio UnitのAudioComponentDescriptionを作成
    AudioComponentDescription cd;
    cd.componentType = kAudioUnitType_Output;
    cd.componentSubType = kAudioUnitSubType_RemoteIO;
    cd.componentManufacturer = kAudioUnitManufacturer_Apple;
    cd.componentFlags = 0;
    cd.componentFlagsMask = 0;
    
    //AudioComponentDescriptionからAudioComponentを取得
    AudioComponent component = AudioComponentFindNext(NULL, &cd);
    
    //AudioComponentとAudioUnitのアドレスを渡してAudioUnitを取得
    AudioComponentInstanceNew(component, &audioUnit);
    
    //AudioUnitを初期化
    AudioUnitInitialize(audioUnit);
    
    AURenderCallbackStruct callbackStruct;
    callbackStruct.inputProc = renderCallback;//コールバック関数の設定
    callbackStruct.inputProcRefCon = &cuteWaveDef;//コールバック関数内で参照するデータのポインタ
    
    AudioUnitSetProperty(audioUnit, 
                         kAudioUnitProperty_SetRenderCallback, 
                         kAudioUnitScope_Input, //サイン波の値はAudioUnitに入ってくるものなのでScopeはInput
                         0,   // 0 == スピーカー
                         &callbackStruct,
                         sizeof(AURenderCallbackStruct));
    
    cuteWaveDef.sampleRate = 44100.0;
    cuteWaveDef.phase = 0.0;
    cuteWaveDef.factor = 0.0;
    
    [self setFrequency:440];
    cuteWaveDef.freqz = cuteWaveDef.freqz;
    
    AudioStreamBasicDescription audioFormat;
    audioFormat.mSampleRate         = cuteWaveDef.sampleRate;
    audioFormat.mFormatID           = kAudioFormatLinearPCM;
    audioFormat.mFormatFlags        = kAudioFormatFlagsAudioUnitCanonical;
    audioFormat.mChannelsPerFrame   = 2;
    audioFormat.mBytesPerPacket     = sizeof(AudioUnitSampleType);
    audioFormat.mBytesPerFrame      = sizeof(AudioUnitSampleType);
    audioFormat.mFramesPerPacket    = 1;
    audioFormat.mBitsPerChannel     = 8 * sizeof(AudioUnitSampleType);
    audioFormat.mReserved           = 0;
    
    AudioUnitSetProperty(audioUnit,
                         kAudioUnitProperty_StreamFormat,
                         kAudioUnitScope_Input,
                         0,
                         &audioFormat,
                         sizeof(audioFormat));
    
    //フレームバッファサイズの変更
    {
        AudioSessionInitialize(NULL, NULL, NULL,NULL);
        Float32 currentDuration;
        UInt32 size = sizeof(Float32);        
        AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareIOBufferDuration, 
                                &size, 
                                &currentDuration);
        printf("currentDuration = %f\n",currentDuration);
        
        //フレーム数から秒を計算 256 = 希望するフレーム数
        Float32 duration = 256 / cuteWaveDef.sampleRate;
        printf("duration = %f\n",duration);
        //IOBufferDurationを変更する
        size = sizeof(Float32);
        AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareIOBufferDuration, 
                                size,
                                &duration);
        
        //変更後の値を確認してみる
        Float32 newDuration;
        size = sizeof(Float32);
        AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareIOBufferDuration, 
                                &size, 
                                &newDuration);
        printf("newDuration = %f\n",newDuration);
        NSLog(@"frame size = %f", cuteWaveDef.sampleRate * newDuration);
    }
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