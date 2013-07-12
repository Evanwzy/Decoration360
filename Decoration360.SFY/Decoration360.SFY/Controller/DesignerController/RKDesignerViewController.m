//
//  RKDesignerViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-12.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKDesignerViewController.h"

@interface RKDesignerViewController ()

@end

@implementation RKDesignerViewController

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
}

- (void)viewDidAppear:(BOOL)animated {
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.getExperterInfoDelegate =self;
    [manager getExporterInfoWithAppID];
}

-(void)getExperterInfo:(NSDictionary *)expertInfo {
    NSLog(@"%@", expertInfo);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
