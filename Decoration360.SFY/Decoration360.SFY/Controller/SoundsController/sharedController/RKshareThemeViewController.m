//
//  RKshareThemeViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-20.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKshareThemeViewController.h"
#import "RKHomeViewController.h"


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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sharedBtnPressed:(id)sender {
    RKNetworkRequestManager *manager=[RKNetworkRequestManager sharedManager];
    
    [manager sharedTheme:[_imageFile stringByAppendingFormat:@".png"] :[_mp3File stringByAppendingFormat:@".aac"] ];
    manager.sharedImageDelegate =self;
}
- (void)dealloc {
    [_imageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImageView:nil];
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
