//
//  RKContentViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-1.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKNetworkRequestManager.h"
#import "UIKeyboardViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface RKContentViewController : UIViewController<UIKeyboardViewControllerDelegate, AVAudioRecorderDelegate, RKRequestManagerContentDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, RKRequestManagerDownloadVoiceDelegate> {
    UIKeyboardViewController *keyBoardController;
    AVAudioRecorder *recorder;
    NSTimer *timer;
    NSURL *urlPlay;
    AVAudioPlayer *audioPlayer;
}

@property (retain, nonatomic) NSString *tid;
@property (retain, nonatomic) UIImage  *picImage;
@property (retain, nonatomic) NSString *urlStr;
@property (nonatomic) BOOL isRecording;
@property (retain, nonatomic) AVAudioPlayer *avPlay;
@property (retain, nonatomic) NSString *mp3File;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIImageView *recordView;
@property (retain, nonatomic) UIImageView *picImgView;
@property (retain, nonatomic) IBOutlet UIButton *commitVoiceBtn;
@property (retain, nonatomic) IBOutlet UITextField *commitTextField;
@property (retain, nonatomic) IBOutlet UIButton *sendBtn;

- (IBAction)changeBtnPressed:(UIButton *)sender;
- (IBAction)sendBtnPressed:(UIButton *)sender;
- (IBAction)backBtnPressed:(id)sender;

@property (retain, nonatomic) NSDictionary *dictData;
@property (retain, nonatomic) NSArray *commentArray;

@end
