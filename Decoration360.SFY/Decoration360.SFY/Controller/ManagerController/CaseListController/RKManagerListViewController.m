//
//  RKManagerListViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-12.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKManagerListViewController.h"
#import "RKNewCaseViewController.h"
#import "RKManagerListViewCell.h"
#import "RKPhotoTalkingViewController.h"
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
    _tableView =[[UITableView alloc]init];
    [_tableView setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 460.0f)];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    [self.view addSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated {
    [Common cancelAllRequestOfAllQueue];
    
    [self requestData:0];
}

- (void)requestData :(int)stepNum {
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.getManagerListDelegate =self;
    [manager getManagerList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}



-(void)managerListQueryData:(NSDictionary *)dict {
    _num =[[dict objectForKey:@"num"] intValue];
    self.dataArray =[dict objectForKey:@"data"];
    [self setupTableView];
}
- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)newBtnPressed:(id)sender {
    RKNewCaseViewController *nvCtr=[[RKNewCaseViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:nvCtr];
    [nvCtr release];
}

- (IBAction)backBtn:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:nil];
}

#pragma mark - tableView
- (void)setupTableView {
    [_tableView reloadData];
}


//tableDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier =@"Cell";
    
    RKManagerListViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        NSArray *xib=[[NSBundle mainBundle] loadNibNamed:@"RKManagerListViewCell" owner:self options:nil];
        cell =(RKManagerListViewCell *)[xib objectAtIndex:0];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.highlighted =NO;
    
    NSDictionary *dataDict =[_dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text =[dataDict objectForKey:@"name"];
    cell.addrLabel.text =[NSString stringWithFormat:@"%@%@%@", [dataDict objectForKey:@"province"], [dataDict objectForKey:@"city"], [dataDict objectForKey:@"region"]];
    
    return cell;
}

//tableDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //action
    NSDictionary *dataDict =[_dataArray objectAtIndex:indexPath.row];
    RKPhotoTalkingViewController *ptvCtr =[[RKPhotoTalkingViewController alloc]init];
    ptvCtr.type =PROJECT;
    ptvCtr.tid =[dataDict objectForKey:@"id"];
    ptvCtr.step =YINBI;

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:ptvCtr];
}


@end
