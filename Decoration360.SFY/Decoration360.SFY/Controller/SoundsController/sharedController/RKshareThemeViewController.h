//
//  RKshareThemeViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-20.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKNetworkRequestManager.h"

@interface RKshareThemeViewController : UIViewController <RKRequestManagerExperterInfoDelegate, RKRequestManagerSharedImageDelegate>

@property (retain, nonatomic) NSString *imageFile;
@property (retain ,nonatomic  ) NSString *mp3File;


@property int type;
@property int step;
@property (retain, nonatomic) NSString *tid;
@property int btnTag;

@property (retain, nonatomic) IBOutlet UIButton *designerImg1;
@property (retain, nonatomic) IBOutlet UIButton *designerImg2;
@property (retain, nonatomic) IBOutlet UIButton *designerImg3;
@property (retain, nonatomic) IBOutlet UIButton *designerImg4;
@property (retain, nonatomic) IBOutlet UIButton *designerImg5;
@property (retain, nonatomic) IBOutlet UIButton *designerImg6;
@property (retain, nonatomic) IBOutlet UIButton *designerImg7;
@property (retain, nonatomic) IBOutlet UIButton *designerImg8;


@property (retain, nonatomic) IBOutlet UIButton *takePicBtn;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)sharedBtnPressed:(id)sender;
- (IBAction)takePic:(id)sender;
@end
