//
//  RKCaseListViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-5.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKCaseListViewController.h"
#import "Common.h"

@interface RKCaseListViewController ()

@end

@implementation RKCaseListViewController

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

-(void)viewWillAppear:(BOOL)animated {
    [Common cancelAllRequestOfAllQueue];
    [self requestDataQuery];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_btnStyle release];
    [_btnSite release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBtnStyle:nil];
    [self setBtnSite:nil];
    [super viewDidUnload];
}

#pragma mark - NIbtn&delegate
- (IBAction)btnStyleClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"全部风格", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",nil];
    if(dropDwon == nil) {
        CGFloat f = 200;
        dropDwon = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDwon.delegate = self;
    }
    else {
        [dropDwon hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)btnSiteClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"全部功能", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",nil];
    if(dropDwon == nil) {
        CGFloat f = 200;
        dropDwon = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDwon.delegate = self;
    }
    else {
        [dropDwon hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)backPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:nil];
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    NSLog(@"%@", _btnStyle.titleLabel.text);
    NSLog(@"%@", _btnSite.titleLabel.text);
    
    [Common cancelAllRequestOfAllQueue];
    [self requestDataQuery];
    
    [self rel];
}

-(void)rel{
    [dropDwon release];
    dropDwon = nil;
}

#pragma mark - requestData&delegate

- (void)requestDataQuery {
    [Common cancelAllRequestOfAllQueue];
    
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.caseListDelegate =self;
    [manager getCaseInfoWithStyle:_btnStyle.titleLabel.text andSite:_btnSite.titleLabel.text];
}



@end
