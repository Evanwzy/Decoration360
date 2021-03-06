//
//  RKCaseListViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-5.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKCaseListViewController.h"
#import "Common.h"
#import "RKCaseListViewCell.h"
#import "UIButton+WebCache.h"

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
    [_imageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBtnStyle:nil];
    [self setBtnSite:nil];
    [self setImageView:nil];
    [super viewDidUnload];
}

#pragma mark - NIDrop Button Delegate
- (void) niDropDownDelegateMethod: (NIDropDown *) sender :(NSString *)text :(int)indexPath{
    
    if([sender isEqual:dropDown]) {
        [self.btnStyle setTitle:text forState:UIControlStateNormal];
        [self rel:sender];
    }else if([sender isEqual:dropDown2]) {
        [self.btnSite setTitle:text forState:UIControlStateNormal];
        [self rel:sender];
    }
    [self requestDataQuery];
}

-(void)rel :(NIDropDown *)sender{
    if([sender isEqual:dropDown]) {
        self.btnSite.selected =NO;
        dropDown = nil;
    }else if([sender isEqual:dropDown2]) {
        self.btnStyle.selected =NO;
        dropDown2 = nil;
    }
    
}

-(void)relBtn :(id)sender{
    if([sender isEqual:self.btnStyle]) {
        self.btnSite.selected =NO;
        dropDown = nil;
    }else if([sender isEqual:self.btnSite]) {
        self.btnSite.selected =NO;
        dropDown2 = nil;
    }
    
}


- (IBAction)btnStyleClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"全部风格", @"简约", @"中式", @"欧美", @"地中海", @"异域", @"混搭", nil];
    if(dropDown == nil) {
        self.btnStyle.selected =YES;
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self relBtn:sender];
    }
    
    if(dropDown2 != nil) {
        [dropDown2 hideDropDown:self.btnSite];
        [self relBtn:self.btnSite];
    }
}

- (IBAction)btnSiteClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"全部功能", @"厨房", @"卫浴", @"客厅", @"卧室", @"餐厅", @"儿童房", @"书房", @"整体衣帽间", @"玄关", @"阳台阳光房", @"楼梯", @"储藏室", @"其他空间", @"户外庭院", nil];
    if(dropDown2 == nil) {
        self.btnSite.selected =YES;
        CGFloat f = 120;
        dropDown2 = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDown2.delegate = self;
    }
    else {
        [dropDown2 hideDropDown:sender];
        [self relBtn:sender];
    }
    
    if(dropDown != nil) {
        [dropDown hideDropDown:self.btnStyle];
        [self relBtn:self.btnStyle];
    }
}

- (IBAction)backPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:nil];
}

#pragma mark - requestData&delegate

- (void)requestDataQuery {
    [Common cancelAllRequestOfAllQueue];
    
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.caseListDelegate =self;
    [manager getCaseInfoWithStyle:_btnStyle.titleLabel.text andSite:_btnSite.titleLabel.text];
}

-(void)caseListQueryData:(NSDictionary *)dict{
    NSLog(@"%@", dict);
    
    self.dataArray =[dict objectForKey:@"data"];
    _num =[[dict objectForKey:@"num"] intValue];
    if (_num !=0) {
        [_imageView setHidden:YES];
        [self setTableView];
    }else {
        [_imageView setHidden:NO];
        [self setTableView];
        [self.view bringSubviewToFront:_imageView];
    }
}


#pragma mark - settingTableView
- (void)setTableView {
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0.0f, 51.0f, 320.0f, 445.0f)];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    [_tableView reloadData];
    [self.view addSubview:_tableView];
}

//tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_num ==0) {
        return 0;
    }else if (_num%2 ==0){
        return _num/2;
    }else {
        return _num/2+1;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    RKCaseListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        NSArray *xib=[[NSBundle mainBundle] loadNibNamed:@"RKCaseListViewCell" owner:self options:nil];
        cell =(RKCaseListViewCell *)[xib objectAtIndex:0];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.highlighted =NO;
    cell.arr =_dataArray;
    int i =_num%2;
    int j =indexPath.row*2;
    int k =indexPath.row*2+1;
    NSURL *url1=[NSURL URLWithString:[[_dataArray objectAtIndex:j] objectForKey:@"url"]];
    cell.num1 =j;
    if (i ==0) {
        NSURL *url2=[NSURL URLWithString:[[_dataArray objectAtIndex:k] objectForKey:@"url"]];
        cell.num2 =k;
        [cell.caseBtn_1 setBackgroundImageWithURL:url1 forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_default"]];
        [cell.caseBtn_2 setBackgroundImageWithURL:url2 forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_default"]];
    }else if (_num/2 ==indexPath.row){
        [cell.caseBtn_1 setBackgroundImageWithURL:url1 forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_default"]];
    }else {
        NSURL *url2=[NSURL URLWithString:[[_dataArray objectAtIndex:k] objectForKey:@"url"]];
        cell.num2 =k;
        [cell.caseBtn_1 setBackgroundImageWithURL:url1 forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_default"]];
        [cell.caseBtn_2 setBackgroundImageWithURL:url2 forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_default"]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}
@end
