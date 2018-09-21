//
//  LFAudioRecordViewController.m
//  LFPoems
//
//  Created by Xiangconnie on 16/4/17.
//  Copyright © 2016年 HUST. All rights reserved.
//

#import "LFAudioRecordViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LFAudioRecordViewController () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

//@property (nonatomic, strong) AVPlayer *player;

@end

@implementation LFAudioRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupAudioComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions 

- (void)setupAudioComponents {
    [self setupAudioRecorder];
    [self setupAudioPlayer];
}

- (void)setupAudioRecorder {
    NSString *pathOfRecordingFile = [self recordingPath];
    NSURL *audioRecordingUrl = [NSURL fileURLWithPath:pathOfRecordingFile];
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:audioRecordingUrl settings:[self audioRecordingSettings] error:&error];
    self.audioRecorder.delegate = self;
#warning 这里要通过界面来控制
    if ([self.audioRecorder prepareToRecord] && [self.audioRecorder record]) {
        NSLog(@"录制声音开始！");
     
#warning 用gcd来控制
        [self performSelector:@selector(stopRecordingOnAudioRecorder:)
                   withObject:self.audioRecorder
                   afterDelay:10.0f];
    }
}

- (void)setupAudioPlayer {
    
}

//停止音频的录制
- (void)stopRecordingOnAudioRecorder:(AVAudioRecorder *)recorder {
    [recorder stop];
}

#warning 要结合应用程序状态的改变作一些处理.
- (void)stopAudioActions {
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
    }
    
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    }
}

#pragma mark - Helper Methods

- (NSString *)recordingPath {
#warning 要输入自己保存的名字。最好是按照一个规则自动命名
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsFolde = [folders objectAtIndex:0];
    return [documentsFolde stringByAppendingPathComponent:@"Recording.m4a"];
}

//在初始化AVAudioRecord实例之前，需要进行基本的录音设置
- (NSDictionary *)audioRecordingSettings {  
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    [settings setValue:[NSNumber numberWithInteger:kAudioFormatAppleLossless]
                forKey:AVFormatIDKey];
    [settings setValue:[NSNumber numberWithFloat:44100.0f] forKey:AVSampleRateKey];
    [settings setValue:[NSNumber numberWithInteger:1] forKey:AVNumberOfChannelsKey];
    [settings setValue:[NSNumber numberWithInteger:AVAudioQualityLow]
                forKey:AVEncoderAudioQualityKey];
    return settings;
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"录音完成！");
        NSError *playbackError = nil;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:&playbackError];
#warning 这里直接用上面的url应该就可以了

//        NSError *readingError = nil;
//        NSData *fileData = [NSData dataWithContentsOfFile:[self recordingPath] options:NSDataReadingMapped error:&readingError];
//        AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithData:fileData
//                                                                 error:&playbackError];
        
        self.audioPlayer.delegate = self;
        if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]) {
            NSLog(@"开始播放录制的音频！");
        } else {
            NSLog(@"不能播放录制的音频！");
        }
    } else {
        NSLog(@"录音过程意外终止！");
    }
}

@end
