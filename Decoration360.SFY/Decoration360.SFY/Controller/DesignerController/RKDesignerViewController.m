//
//  RKDesignerViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-12.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKDesignerViewController.h"
#import "RKDesignerViewCell.h"
#import "UIImageView+WebCache.h"

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
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 460.0f)];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _num =0;
}

- (void)viewDidAppear:(BOOL)animated {
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.getExperterInfoDelegate =self;
    [manager getExporterInfoWithAppID];
}

-(void)getExperterInfo:(NSDictionary *)expertInfo {
    _num =[[expertInfo objectForKey:@"num"] intValue];
    self.dataArr = [expertInfo objectForKey:@"data"];
    [_tableView reloadData];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dataDict =[_dataArr objectAtIndex:indexPath.row];
    
    NSString *identifier =@"Cell";
    
    RKDesignerViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        NSArray *xib=[[NSBundle mainBundle] loadNibNamed:@"RKDesignerViewCell" owner:self options:nil];
        cell =(RKDesignerViewCell *)[xib objectAtIndex:0];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.nameLabel.text =[dataDict objectForKey:@"nickname"];
    [cell.iconImageView setImageWithURL:[dataDict objectForKey:@"avatar"] placeholderImage:[UIImage imageNamed:@"icon_default.png"]];
    
    return cell;
}

- (IBAction)backBtn:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:nil];
}
@end
