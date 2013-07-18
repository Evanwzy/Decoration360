//
//  RKtakingVoiceViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-18.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKtakingVoiceViewController.h"
#import "RKtakingPhotoViewController.h"
#import "RKshareThemeViewController.h"
#import "RKPhotoTalkingViewController.h"
#import "Common.h"
#import "UIImage+Scale.h"
#import "lame.h"

@interface RKtakingVoiceViewController ()

@end

@implementation RKtakingVoiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.image =_preImage;
    UIImage *image = [_preImage scaleImage:_preImage toScale:0.264];
    NSData *dataImage;
    self.imageFile = [Common getTime];
    dataImage = UIImagePNGRepresentation(image);
    [dataImage writeToFile:[Common pathForImage:[NSString stringWithFormat:@"%@.png", _imageFile]] atomically:YES];
    
    //settingVedio
    [_recordView setHidden:YES];
    [self audio];
    [_recordBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [_recordBtn addTarget:self action:@selector(btnUp:) forControlEvents:UIControlEventTouchUpInside];
    [_recordBtn addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragExit];
}

#pragma mark - buttonAction
- (IBAction)btnDown:(id)sender
{
    [_recordView setHidden:NO];
    //创建录音文件，准备录音
    if ([recorder prepareToRecord]) {
        //开始
        [recorder record];
    }
    
    //设置定时检测
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
}
- (IBAction)btnUp:(id)sender
{
    [_recordView setHidden:YES];
    double cTime = recorder.currentTime;
    if (cTime > 2) {//如果录制时间<2 不发送
        NSLog(@"发出去");
//        [self audio_PCMtoMP3];
    }else {
        //删除记录的文件
        [recorder deleteRecording];
        //删除存储的
    }
    [recorder stop];
    [timer invalidate];
}
- (IBAction)btnDragUp:(id)sender
{
    [_recordView setHidden:YES];
    //删除录制文件
    [recorder deleteRecording];
    [recorder stop];
    [timer invalidate];
    
    NSLog(@"取消发送");
}

#pragma mark - audio operation
- (void)audio
{
    //录音设置
    NSMutableDictionary *recordSetting = [[[NSMutableDictionary alloc]init] autorelease];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.mp3File =[Common getTime];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.aac", strUrl, _mp3File]];
    urlPlay = url;
    
    NSError *error;
    //初始化
    recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
}

- (void)detectionVoice
{
    [recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
//    NSLog(@"%lf",lowPassResults);
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.06) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
    }else if (0.06<lowPassResults<=0.13) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_02.png"]];
    }else if (0.13<lowPassResults<=0.20) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_03.png"]];
    }else if (0.20<lowPassResults<=0.27) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_04.png"]];
    }else if (0.27<lowPassResults<=0.34) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_05.png"]];
    }else if (0.34<lowPassResults<=0.41) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_06.png"]];
    }else if (0.41<lowPassResults<=0.48) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_07.png"]];
    }else if (0.48<lowPassResults<=0.55) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_08.png"]];
    }else if (0.55<lowPassResults<=0.62) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_09.png"]];
    }else if (0.62<lowPassResults<=0.69) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_10.png"]];
    }else if (0.69<lowPassResults<=0.76) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_11.png"]];
    }else if (0.76<lowPassResults<=0.83) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_12.png"]];
    }else if (0.83<lowPassResults<=0.9) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_13.png"]];
    }else {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_14.png"]];
    }
}

- (void) updateImage
{
    [self.recordView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
}



#pragma mark - dealloc Method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageView release];
    [_nextBtn release];
    [_recordLabel release];
    [_recordBtn release];
    [_recordView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImageView:nil];
    [self setNextBtn:nil];
    [self setRecordLabel:nil];
    [self setRecordBtn:nil];
    [self setRecordView:nil];
    [super viewDidUnload];
}
- (IBAction)cancelBtn:(id)sender {
    _imageView.image =nil;
    RKtakingPhotoViewController *tpCtr =[[[RKtakingPhotoViewController alloc]init] autorelease];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:tpCtr];
}

- (IBAction)nextBtn:(id)sender {
    RKshareThemeViewController *stvCtr =[[[RKshareThemeViewController alloc]init] autorelease];
    stvCtr.mp3File =_mp3File;
    stvCtr.imageFile =_imageFile;
    if (_type ==PROJECT) {
        stvCtr.type =PROJECT;
        stvCtr.step =_step;
        stvCtr.tid =_tid;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:stvCtr];
}
@end
