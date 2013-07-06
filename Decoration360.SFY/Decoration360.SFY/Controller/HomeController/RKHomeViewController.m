//
//  RKHomeViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-16.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKHomeViewController.h"
#import "RKPhotoTalkingViewController.h"
#import "RKLoginViewController.h"
#import "RKCaseListViewController.h"
#import "Common.h"

@interface RKHomeViewController ()

@end

@implementation RKHomeViewController

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
    
    [Common checkUserDefault];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [Common cancelAllRequestOfAllQueue];
    
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.homeDelegate =self;
    [self requestQueryData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - requestQuery&Delegate
- (void)requestQueryData {
    [[RKNetworkRequestManager sharedManager] getHomeData];
}

- (void)homeQueryData:(NSMutableArray *)imageArray :(NSMutableArray *)titleArray {
    
    // 初始化自定义ScrollView类对象
    AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:imageArray titleArr:titleArray height:88];
    //设置委托
    aSV.vDelegate=self;
    //添加进view
    [self.view addSubview:aSV];
    [self setUI];
}

- (void)homeQueryDatafaied {
    [self setUI];
}

-(void)buttonClick:(int)vid {
    NSLog(@"%d", vid);
}

#pragma mark - UI
- (void)setUI {
    [self.view bringSubviewToFront:_takingBtn];
    [self.view bringSubviewToFront:_otherBtn];
    [self.view bringSubviewToFront:_caseBtn];
}

- (IBAction)casesBtnPressed:(id)sender {
    RKCaseListViewController *clvCtr =[[RKCaseListViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:clvCtr];
    [clvCtr release];
}

- (IBAction)photoTalkingBtnPressed:(id)sender {
    
    RKPhotoTalkingViewController *ptvCtr =[[RKPhotoTalkingViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:ptvCtr];
    [ptvCtr release];
    
}



- (IBAction)projectmanagerBtnPressed:(id)sender {
}

- (IBAction)activityBtnPressed:(id)sender {
}

- (IBAction)designerBtnPressed:(id)sender {
}

- (IBAction)companyInfoBtnPressed:(id)sender {
}


- (IBAction)otherBtnPressed:(id)sender {
    RKLoginViewController *lvCtr =[[RKLoginViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:lvCtr];
    [lvCtr release];
}
- (void)dealloc {
    [_bgImageView release];
    [_bottomImageView release];
    [_takingBtn release];
    [_otherBtn release];
    [_caseBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBgImageView:nil];
    [self setBottomImageView:nil];
    [self setTakingBtn:nil];
    [self setOtherBtn:nil];
    [self setCaseBtn:nil];
    [super viewDidUnload];
}
@end
