//
//  RKManagerListViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-12.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKManagerListViewController.h"
#import "Common.h"

@interface RKManagerListViewController ()

@end

@implementation RKManagerListViewController

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

-(void)viewDidAppear:(BOOL)animated {
    [Common cancelAllRequestOfAllQueue];
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.getManagerListDelegate =self;
    [manager getManagerList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)managerListQueryData:(NSDictionary *)dict {
    
}
@end
