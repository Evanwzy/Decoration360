//
//  RKContentTableViewCell.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-2.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKContentTableViewCell.h"
#import "Common.h"

@implementation RKContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_playBtn release];
    [_iconImageView release];
    [_contentText release];
    [super dealloc];
}

- (void)playVoice:(NSString *)path {
    NSURL *url =[NSURL URLWithString:path];
    [self voicePlay:url];
}

- (void)voicePlay:(NSURL *)url {
    NSError *error;
    audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url
                                                      error:&error];
    
    audioPlayer.volume=1;
    if (error) {
        NSLog(@"error:%@",[error description]);
        return;
    }
    //准备播放
    [audioPlayer prepareToPlay];
    //播放
    [audioPlayer play];
}
- (IBAction)playBtnPressed:(id)sender {
    [Common cancelAllRequestOfAllQueue];
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.downloadVoiceDelegate =self;
    [manager downloadVoiceWithUrl:_playUrl];
}


@end
