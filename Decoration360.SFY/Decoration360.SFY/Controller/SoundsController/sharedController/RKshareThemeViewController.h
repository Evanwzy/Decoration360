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
@property int btnTag;
@property int dTag;
@property (retain, nonatomic) NSString *tid;
@property (retain, nonatomic) NSMutableArray  *designerData;
@property (retain, nonatomic) NSMutableArray *selectedDesigner;

@property (retain, nonatomic) IBOutlet UIButton *designerImg1;
@property (retain, nonatomic) IBOutlet UIButton *designerImg2;
@property (retain, nonatomic) IBOutlet UIButton *designerImg3;
@property (retain, nonatomic) IBOutlet UIButton *designerImg4;
@property (retain, nonatomic) IBOutlet UIButton *designerImg5;
@property (retain, nonatomic) IBOutlet UIButton *designerImg6;
@property (retain, nonatomic) IBOutlet UIButton *designerImg7;
@property (retain, nonatomic) IBOutlet UIButton *designerImg8;

@property (retain, nonatomic) IBOutlet UIImageView *deleteImg1;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImg2;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImg3;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImg4;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImg5;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImg6;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImg7;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImg8;

@property (retain, nonatomic) IBOutlet UIButton *takePicBtn;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)sharedBtnPressed:(id)sender;
- (IBAction)takePic:(id)sender;
- (IBAction)addDesignerBtn:(id)sender;
@end
