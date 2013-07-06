//
//  RKtakingVoiceViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-18.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface RKtakingVoiceViewController : UIViewController <AVAudioRecorderDelegate>{
    AVAudioRecorder *recorder;
    NSTimer *timer;
    NSURL *urlPlay;
}

@property (retain, nonatomic) UIImage *preImage;
@property (nonatomic) BOOL isRecording;
@property (retain, nonatomic) AVAudioPlayer *avPlay;
@property (retain, nonatomic) NSString *imageFile;
@property (retain, nonatomic) NSString *mp3File;

@property (retain, nonatomic) IBOutlet UILabel *recordLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIImageView *recordView;

@property (retain, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)cancelBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *recordBtn;

- (IBAction)nextBtn:(id)sender;


@end
