//
//  RKtakingPhotoViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-18.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKtakingPhotoViewController.h"
#import "RKPhotoTalkingViewController.h"
#import "RKtakingVoiceViewController.h"
#import "CameraImageHelper.h"
#import "Common.h"

@interface RKtakingPhotoViewController ()

@end

@implementation RKtakingPhotoViewController


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
    UIView *tmpView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 280)];
    self.popView =tmpView;
    [tmpView release];
    [_popView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.popView];
    [CameraImageHelper embedPreviewInView:_liveView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPicture) name:@"GETPICTURE" object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [_popView setHidden:YES];
    _takePhotoBtn.enabled =YES;
    _cancelBtn.enabled =YES;
    _photoBtn.enabled =YES;
    _takePhotoBtn.userInteractionEnabled =YES;
    [CameraImageHelper startRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GETPICTURE" object:nil];
    [_popView release];
    [_liveView release];
    [_takePhotoBtn release];
    [_cancelBtn release];
    [_photoBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPopView:nil];
    [self setLiveView:nil];
    [self setTakePhotoBtn:nil];
    [self setCancelBtn:nil];
    [self setPhotoBtn:nil];
    [super viewDidUnload];
}
- (IBAction)takePhotoBtn:(id)sender {
    _takePhotoBtn.enabled =NO;
    _cancelBtn.enabled =NO;
    _photoBtn.enabled =NO;
    [CameraImageHelper CaptureStillImage];
//    [self performSelector:@selector(getPicture) withObject:nil afterDelay:5.5];
    [CameraImageHelper stopRunning];
    [self performSelector:@selector(getPicture) withObject:nil afterDelay:1.5];
}

- (IBAction)cancelBtn:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:nil];
}

-(void)getPicture
{
    self.image =[CameraImageHelper image];
    NSLog(@"%f,%f",self.image.size.height,self.image.size.width);
    RKtakingVoiceViewController *tvCtr =[[[RKtakingVoiceViewController alloc]init] autorelease];
    tvCtr.preImage = _image;
    if (_type ==PROJECT) {
        tvCtr.type =PROJECT;
        tvCtr.tid =_tid;
        tvCtr.step =_step;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:tvCtr];
}

@end
