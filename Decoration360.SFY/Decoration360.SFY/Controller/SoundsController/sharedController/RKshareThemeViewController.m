//
//  RKshareThemeViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-20.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKshareThemeViewController.h"
#import "RKtakingPhotoViewController.h"
#import "RKPhotoTalkingViewController.h"
#import "RKHomeViewController.h"
#import "Common.h"

@interface RKshareThemeViewController ()

@end

@implementation RKshareThemeViewController

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
    
    
    RKNetworkRequestManager *manager=[RKNetworkRequestManager sharedManager];
    manager.getExperterInfoDelegate =self;
    [manager getExporterInfoWithAppID];
    
    _btnTag =0;
}

-(void)viewDidAppear:(BOOL)animated {
    [_takePicBtn setImage:[UIImage imageWithContentsOfFile:[Common pathForImage:[_imageFile stringByAppendingFormat:@".png"]]] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setBtnAction {
    
}




- (IBAction)sharedBtnPressed:(id)sender {
    RKNetworkRequestManager *manager=[RKNetworkRequestManager sharedManager];
    
    manager.sharedImageDelegate =self;
    
    if (_type ==PROJECT) {
        [manager sharedTheme:[_imageFile stringByAppendingFormat:@".png"] :[_mp3File stringByAppendingFormat:@".aac"] :_step :_tid];
    }else {
        [manager sharedTheme:[_imageFile stringByAppendingFormat:@".png"] :[_mp3File stringByAppendingFormat:@".aac"] ];
    }
}

- (IBAction)takePic:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPTOROOTCONTROLLER" object:nil];
}

- (void)dealloc {
    [_imageView release];
    [_takePicBtn release];
    [_designerImg1 release];
    [_designerImg2 release];
    [_designerImg3 release];
    [_designerImg4 release];
    [_designerImg5 release];
    [_designerImg6 release];
    [_designerImg7 release];
    [_designerImg8 release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setTakePicBtn:nil];
    [self setDesignerImg1:nil];
    [self setDesignerImg2:nil];
    [self setDesignerImg3:nil];
    [self setDesignerImg4:nil];
    [self setDesignerImg5:nil];
    [self setDesignerImg6:nil];
    [self setDesignerImg7:nil];
    [self setDesignerImg8:nil];
    [super viewDidUnload];
}

-(void)getExperterInfo:(NSArray *)expertInfo {
    
}

-(void)sharedStatus {
    RKHomeViewController *hvCtr =[[RKHomeViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPTOROOTCONTROLLER" object:hvCtr];
    [hvCtr release];
}
@end
