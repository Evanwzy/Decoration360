//
//  RKPhotoTalkingViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-17.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKPhotoTalkingViewController.h"
#import "RKtakingPhotoViewController.h"
#import "RKHomeViewController.h"
#import "RKLoginViewController.h"
#import "Common.h"
#import "RKCommitTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface RKPhotoTalkingViewController ()

@end

@implementation RKPhotoTalkingViewController


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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNum) name:@"ADDREQUESTNUM" object:nil];
    
    if (_type ==PROJECT) {
        [self setProjectUI];
    }
    
    [_tableView setHidden:YES];
    
    // Do any additional setup after loading the view from its nib.
    
//    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 460.0f)];
//    _tableView.delegate =self;
//    _tableView.dataSource =self;
//    [self.view addSubview:_tableView];
}
-(void)viewWillAppear:(BOOL)animated {
    [Common cancelAllRequestOfAllQueue];
    self.array =nil;
    _array = [[NSMutableArray alloc]init];
//    [self requestDataQuery];
    
    _requestNum =3;
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *h_view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		h_view.delegate = self;
		[self.tableView addSubview:h_view];
		_refreshHeaderView = h_view;
		[h_view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    
    [self requestDataQuery];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ADDREQUESTNUM" object:nil];
    [super dealloc];
}

- (void)addNum {
    if (_requestNum <=[_commitArray count]) {
        _requestNum =_requestNum +3;
    }
    NSLog(@"%d", _requestNum);
    [self requestDataQuery];
}

- (void)requestDataQuery {
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.getThemeInformationDelegate =self;
    [[RKNetworkRequestManager sharedManager] getThemeInfoFrom:@"0" To:[NSString stringWithFormat:@"%d", _requestNum]];
}

/*
- (void)setup :(int)i {
    
    NSDictionary *commitDict =[_commitArray objectAtIndex:i];
    NSArray *commentArray =[commitDict valueForKey:@"comments"];
    NSString *themeImgUrl =[commitDict valueForKey:@"pic_url"];
    NSString *themeVoiceUrl =[commitDict valueForKey:@"voice_url"];
    _commentNum =[[commitDict valueForKey:@"num"] intValue];
    NSString *commitIcon_1 =@"";
    NSString *commitIcon_2 =@"";
    NSString *commitIcon_3 =@"";
    NSDictionary *commitDict_1;
    NSDictionary *commitDict_2;
    NSDictionary *commitDict_3;
    
    NSLog(@"%d", _commentNum);
    if (_commentNum >0) {
        commitDict_1 =[commentArray objectAtIndex:0];
        commitIcon_1 =[commitDict_1 valueForKey:@"pic_url"];
    }
    if (_commentNum >1) {
        commitDict_2 =[commentArray objectAtIndex:1];
        commitIcon_2 =[commitDict_2 valueForKey:@"pic_url"];
    }
    if (_commentNum >2){
        commitDict_3 =[commentArray objectAtIndex:2];
        commitIcon_3 =[commitDict_3 valueForKey:@"pic_url"];
    }
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.downloadThemePicDelegate =self;
    [manager downloadThemeWithPicUrl:themeImgUrl iconUrl_1:commitIcon_1 iconUrl_2:commitIcon_2 iconUrl_3:commitIcon_3 andVoiceUrl:themeVoiceUrl Num:_commentNum];
}
*/

/*
- (void)setupCommitView :(int)num {
    NSDictionary *commitDict_1 =[_commitArray objectAtIndex:_countNum];
    NSArray *commentArray =[commitDict_1 objectForKey:@"comments"];
    if (num >0) {
        _commitId_1 =[[commentArray objectAtIndex:0] objectForKey:@"uid"];
        _commitContent_1 =[[commentArray objectAtIndex:0] objectForKey:@"content"];
        _commitVoiceUrl_1 =[[commentArray objectAtIndex:0] objectForKey:@"voice_url"];
    }
    if (num >1) {
        _commitId_2 =[[commentArray objectAtIndex:1] objectForKey:@"uid"];
        _commitContent_2 =[[commentArray objectAtIndex:1] objectForKey:@"content"];
        _commitVoiceUrl_2 =[[commentArray objectAtIndex:0] objectForKey:@"voice_url"];
    }
    if (num >2) {
        _commitId_3 =[[commentArray objectAtIndex:2] objectForKey:@"uid"];
        _commitContent_3 =[[commentArray objectAtIndex:2] objectForKey:@"content"];
        _commitVoiceUrl_3 =[[commentArray objectAtIndex:0] objectForKey:@"voice_url"];
    }
    NSMutableDictionary *commitDict =[[NSMutableDictionary alloc]init];
    //New CommitView
    [commitDict setValue:_pic forKey:@"pic"];
    [commitDict setValue:[NSNumber numberWithInt:_Id] forKey:@"playBtn"];
    if (num >0) {
        if (_commitContent_1.length !=0) {
            self.commitContent_1 =[NSString stringWithFormat:@"%@: %@", _commitId_1, _commitContent_1];
            [commitDict setValue:@"y" forKey:@"btnHidden_1"];
            self.commitContent_1 =[NSString stringWithFormat:@"%@:", _commitId_1];
        }else {
            [commitDict setValue:@"n" forKey:@"btnHidden_1"];
            self.commitContent_1 =[NSString stringWithFormat:@"%@:", _commitId_1];
        }
        [commitDict setValue:_icon_1 forKey:@"icon_1"];
        [commitDict setValue:_commitContent_1 forKey:@"commitContent_1"];
        
    }
    if (num >1) {
        if (_commitContent_2.length !=0) {
            self.commitContent_2 =[NSString stringWithFormat:@"%@: %@", _commitId_2, _commitContent_2];
            [commitDict setValue:@"y" forKey:@"btnHidden_2"];
        }else {
            [commitDict setValue:@"n" forKey:@"btnHidden_2"];
            self.commitContent_2 =[NSString stringWithFormat:@"%@:", _commitId_2];
        }
        [commitDict setValue:_icon_2 forKey:@"icon_2"];
        [commitDict setValue:_commitContent_2 forKey:@"commitContent_2"];
    }
    if (num >2){
        if (_commitContent_3.length !=0) {
            self.commitContent_3 =[NSString stringWithFormat:@"%@: %@", _commitId_3, _commitContent_3];
            [commitDict setValue:@"y" forKey:@"btnHidden_3"];
        }else {
            [commitDict setValue:@"n" forKey:@"btnHidden_3"];
            self.commitContent_3 =[NSString stringWithFormat:@"%@:", _commitId_3];
        }
        [commitDict setValue:_icon_3 forKey:@"icon_3"];
        [commitDict setValue:_commitContent_3 forKey:@"commitContent_3"];
    }
    
    [_array addObject:commitDict];
    if ([_array count]==[_commitArray count]) {
//        [self setupUI:_array];
        
        [_tableView reloadData];
    } else {
        
        _countNum ++;
        [self setup:_countNum];
    }
}
*/

//- (void)setupUI:(NSMutableArray *)arr {
//    //    [_aoView addSubview:_imgView];
//    for (int i =0; i <[arr count]; i++) {
//        [_aoView addSubview:[arr objectAtIndex:i]];
//    }
//    [_aoView setContentSize:CGSizeMake(320.0f, 500.0f *[arr count])];
//    _aoView.delegate =self;
//    [self createHeaderView];
//    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:0.0f];
//    
//    [self.view addSubview:_aoView];
//    [self.view reloadInputViews];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadSoundBtnPressed:(id)sender {
//    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
//    [manager uploadSounds];
    [Common cancelAllRequestOfAllQueue];
    if ([Common isLogined]) {
        RKtakingPhotoViewController *tpvCtr =[[RKtakingPhotoViewController alloc]init];
        if (_type ==PROJECT) {
            tpvCtr.type =PROJECT;
            tpvCtr.tid =_tid;
            tpvCtr.step =_step;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:tpvCtr];
        [tpvCtr release];
    }else {
        UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"请先登陆！" message:@"先登录才能发布主题" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] autorelease];
        alert.delegate =self;
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex ==1) {
        RKLoginViewController *lvCtr =[[RKLoginViewController alloc]init];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:lvCtr];
        [lvCtr release];
    }
}

- (IBAction)backBtnPressed:(id)sender {
    RKHomeViewController *hvCtr =[[RKHomeViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:hvCtr];
    [hvCtr release];
}

- (IBAction)uploadImgBtnPressed:(id)sender {
    [[RKNetworkRequestManager sharedManager] uploadImg];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [_commitArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    RKCommitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        NSArray *xib=[[NSBundle mainBundle] loadNibNamed:@"RKCommitTableViewCell" owner:self options:nil];
        cell =(RKCommitTableViewCell *)[xib objectAtIndex:0];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setHighlighted:NO];
    cell.selected =NO;
    int indexNum =[_commitArray count];
    
    if (indexPath.row == indexNum) {
        [cell.themeImageView setHidden:YES];
        [cell.commitPlayBtn setHidden:YES];
        [cell.commit_icon_1 setHidden:YES];
        [cell.commit_content_1 setHidden:YES];
        [cell.commentPlayBtn_1 setHidden:YES];
        [cell.commit_icon_2 setHidden:YES];
        [cell.commit_content_2 setHidden:YES];
        [cell.commentPlayBtn_2 setHidden:YES];
        [cell.commit_icon_3 setHidden:YES];
        [cell.commit_content_3 setHidden:YES];
        [cell.commentPlayBtn_3 setHidden:YES];
        [cell.moreBtn setHidden:YES];
        [cell.nextBtn setHidden:NO];
        cell.nextBtn.frame =CGRectMake(0.0f, 2.0f, 320.0f, 20.0f);
        cell.requestNum =_requestNum;
        return cell;
    }else {
        NSDictionary *commitDict =[_commitArray objectAtIndex:indexPath.row];
        NSArray *commentArray =[commitDict objectForKey:@"comments"];
        [cell.themeImageView setImageWithURL:[NSURL URLWithString:[commitDict objectForKey:@"pic_url"]] placeholderImage:[UIImage imageNamed:@"icon_default.png"]];
        cell.voiceURL =[commitDict objectForKey:@"voice_url"];
        cell.tid =[commitDict objectForKey:@"id"];
        int num =[[commitDict objectForKey:@"num"]intValue];
        [cell.commit_icon_1 setHidden:YES];
        [cell.commit_content_1 setHidden:YES];
        [cell.commentPlayBtn_1 setHidden:YES];
        [cell.commit_icon_2 setHidden:YES];
        [cell.commit_content_2 setHidden:YES];
        [cell.commentPlayBtn_2 setHidden:YES];
        [cell.commit_icon_3 setHidden:YES];
        [cell.commit_content_3 setHidden:YES];
        [cell.commentPlayBtn_3 setHidden:YES];
        [cell.nextBtn setHidden:YES];
        cell.moreBtn.frame =CGRectMake(0.0f, 421.0f, 320.0f, 20.0f);
        
        if (num >0) {
            NSDictionary *commentDict =[commentArray objectAtIndex:0];
            [cell.commit_icon_1 setImageWithURL:[NSURL URLWithString:[commentDict objectForKey:@"pic_url"]] placeholderImage:[UIImage imageNamed:@"icon_default.png"]];     
            cell.moreBtn.frame =CGRectMake(0.0f, 484.0f, 320.0f, 20.0f);
            NSString *contentText =[commentDict objectForKey:@"content"];
            NSString *contentID =[commentDict objectForKey:@"uid"];
            if (contentText.length !=0) {
                [cell.commit_icon_1 setHidden:NO];
                [cell.commit_content_1 setHidden:NO];
                cell.commit_content_1.text =[NSString stringWithFormat:@"%@: %@", contentID, contentText];
            }else {
                [cell.commit_icon_1 setHidden:NO];
                [cell.commit_content_1 setHidden:NO];
                [cell.commentPlayBtn_1 setHidden:NO];
                cell.commit_content_1.text =[NSString stringWithFormat:@"%@: ", contentID];
                cell.btnUrl_1 =[commentDict objectForKey:@"voice_url"];
            }
        }
        if (num >1) {
            NSDictionary *commentDict =[commentArray objectAtIndex:1];
            [cell.commit_icon_2 setImageWithURL:[NSURL URLWithString:[commentDict objectForKey:@"pic_url"]] placeholderImage:[UIImage imageNamed:@"icon_default.png"]];
            cell.moreBtn.frame =CGRectMake(0.0f, 563.0f, 320.0f, 20.0f);
            NSString *contentText =[commentDict objectForKey:@"content"];
            NSString *contentID =[commentDict objectForKey:@"uid"];
            if (contentText.length !=0) {
                [cell.commit_icon_2 setHidden:NO];
                [cell.commit_content_2 setHidden:NO];
                cell.commit_content_2.text =[NSString stringWithFormat:@"%@: %@", contentID, contentText];
            }else {
                [cell.commit_icon_2 setHidden:NO];
                [cell.commit_content_2 setHidden:NO];
                [cell.commentPlayBtn_2 setHidden:NO];
                cell.commit_content_2.text =[NSString stringWithFormat:@"%@: ", contentID];
                cell.btnUrl_2 =[commentDict objectForKey:@"voice_url"];
            }
        }
        if (num >2){
            NSDictionary *commentDict =[commentArray objectAtIndex:2];
            [cell.commit_icon_3 setImageWithURL:[NSURL URLWithString:[commentDict objectForKey:@"pic_url"]] placeholderImage:[UIImage imageNamed:@"icon_default.png"]];
            cell.moreBtn.frame =CGRectMake(0.0f, 620.0f, 320.0f, 20.0f);
            NSString *contentText =[commentDict objectForKey:@"content"];
            NSString *contentID =[commentDict objectForKey:@"uid"];
            if (contentText.length !=0) {
                [cell.commit_icon_3 setHidden:NO];
                [cell.commit_content_3 setHidden:NO];
                cell.commit_content_3.text =[NSString stringWithFormat:@"%@: %@", contentID, contentText];
            }else {
                [cell.commit_icon_3 setHidden:NO];
                [cell.commit_content_3 setHidden:NO];
                [cell.commentPlayBtn_3 setHidden:NO];
                cell.commit_content_3.text =[NSString stringWithFormat:@"%@: ", contentID];
                cell.btnUrl_3 =[commentDict objectForKey:@"voice_url"];
            }
            
        }
        // Configure the cell.
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *commitDict =[_commitArray objectAtIndex:indexPath.row];
//    int num =[[commitDict objectForKey:@"num"]intValue];
//    if (num >0) {
//        return 347.0f;
//    }else if (num >1) {
//        return 426.0f;
//    }else if (num >2){
//        return 502.0f;
//    }else {
//        return 284.0f;
//    }
    int indexNum =[_commitArray count];
    if (indexNum ==0) {
        return 460.0f;
    }else {
        if (indexPath.row == indexNum) {
            return 24.0f;
        }else {
            return 640.0f;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self requestDataQuery];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


#pragma mark - requestQueryData

-(void)themeInfoData:(NSDictionary *)a {
    self.commitArray =[[NSArray alloc]initWithArray:[a objectForKey:@"data"]];
//    NSLog(@"commit_array:%@", _commitArray);
//    [self setup:_countNum];
    [_tableView setHidden:NO];
    
    [_tableView reloadData];
    [self doneLoadingTableViewData];
}

- (void)setProjectUI{
    _stepBtn_1 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stepBtn_1.tag =1;
    _stepBtn_1.frame =CGRectMake(1.0f, 44.0f, 53.0f, 44.0f);
    [_stepBtn_1 setTitle:@"隐蔽" forState:UIControlStateNormal];
    [_stepBtn_1 addTarget:self action:@selector(stepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _stepBtn_2 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stepBtn_2.tag =2;
    _stepBtn_2.frame =CGRectMake(54.0f, 44.0f, 53.0f, 44.0f);
    [_stepBtn_2 setTitle:@"泥木" forState:UIControlStateNormal];
    [_stepBtn_2 addTarget:self action:@selector(stepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _stepBtn_3 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stepBtn_3.tag =3;
    _stepBtn_3.frame =CGRectMake(107.0f, 44.0f, 53.0f, 44.0f);
    [_stepBtn_3 setTitle:@"油漆" forState:UIControlStateNormal];
    [_stepBtn_3 addTarget:self action:@selector(stepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _stepBtn_4 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stepBtn_4.tag =4;
    _stepBtn_4.frame =CGRectMake(160.0f, 44.0f, 53.0f, 44.0f);
    [_stepBtn_4 setTitle:@"安装" forState:UIControlStateNormal];
    [_stepBtn_4 addTarget:self action:@selector(stepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _stepBtn_5 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stepBtn_5.tag =5;
    _stepBtn_5.frame =CGRectMake(213.0f, 44.0f, 53.0f, 44.0f);
    [_stepBtn_5 setTitle:@"竣工" forState:UIControlStateNormal];
    [_stepBtn_5 addTarget:self action:@selector(stepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _stepBtn_6 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _stepBtn_6.tag =6;
    _stepBtn_6.frame =CGRectMake(266.0f, 44.0f, 53.0f, 44.0f);
    [_stepBtn_6 setTitle:@"软装" forState:UIControlStateNormal];
    [_stepBtn_6 addTarget:self action:@selector(stepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _stepBtn_1.selected =YES;
    _stepBtn_1.userInteractionEnabled =NO;
    
    [self.view addSubview:_stepBtn_1];
    [self.view addSubview:_stepBtn_2];
    [self.view addSubview:_stepBtn_3];
    [self.view addSubview:_stepBtn_4];
    [self.view addSubview:_stepBtn_5];
    [self.view addSubview:_stepBtn_6];
    
    [self requestQuery];
}

- (void)stepBtnAction :(id)sender {
    UIButton *button =sender;
    switch (button.tag) {
        case 1:
            _step =1;
            _stepBtn_1.selected =YES;
            _stepBtn_1.userInteractionEnabled =NO;
            _stepBtn_2.selected =NO;
            _stepBtn_2.userInteractionEnabled =YES;
            _stepBtn_3.selected =NO;
            _stepBtn_3.userInteractionEnabled =YES;
            _stepBtn_4.selected =NO;
            _stepBtn_4.userInteractionEnabled =YES;
            _stepBtn_5.selected =NO;
            _stepBtn_5.userInteractionEnabled =YES;
            _stepBtn_6.selected =NO;
            _stepBtn_6.userInteractionEnabled =YES;
            [self requestQuery];
            break;
        case 2:
            _step =2;
            _stepBtn_1.selected =NO;
            _stepBtn_1.userInteractionEnabled =YES;
            _stepBtn_2.selected =YES;
            _stepBtn_2.userInteractionEnabled =NO;
            _stepBtn_3.selected =NO;
            _stepBtn_3.userInteractionEnabled =YES;
            _stepBtn_4.selected =NO;
            _stepBtn_4.userInteractionEnabled =YES;
            _stepBtn_5.selected =NO;
            _stepBtn_5.userInteractionEnabled =YES;
            _stepBtn_6.selected =NO;
            _stepBtn_6.userInteractionEnabled =YES;
            [self requestQuery];
            break;
        case 3:
            _step =3;
            _stepBtn_1.selected =NO;
            _stepBtn_1.userInteractionEnabled =YES;
            _stepBtn_2.selected =NO;
            _stepBtn_2.userInteractionEnabled =YES;
            _stepBtn_3.selected =YES;
            _stepBtn_3.userInteractionEnabled =NO;
            _stepBtn_4.selected =NO;
            _stepBtn_4.userInteractionEnabled =YES;
            _stepBtn_5.selected =NO;
            _stepBtn_5.userInteractionEnabled =YES;
            _stepBtn_6.selected =NO;
            _stepBtn_6.userInteractionEnabled =YES;
            [self requestQuery];
            break;
        case 4:
            _step =4;
            _stepBtn_1.selected =NO;
            _stepBtn_1.userInteractionEnabled =YES;
            _stepBtn_2.selected =NO;
            _stepBtn_2.userInteractionEnabled =YES;
            _stepBtn_3.selected =NO;
            _stepBtn_3.userInteractionEnabled =YES;
            _stepBtn_4.selected =YES;
            _stepBtn_4.userInteractionEnabled =NO;
            _stepBtn_5.selected =NO;
            _stepBtn_5.userInteractionEnabled =YES;
            _stepBtn_6.selected =NO;
            _stepBtn_6.userInteractionEnabled =YES;
            [self requestQuery];
            break;
        case 5:
            _step =5;
            _stepBtn_1.selected =NO;
            _stepBtn_1.userInteractionEnabled =YES;
            _stepBtn_2.selected =NO;
            _stepBtn_2.userInteractionEnabled =YES;
            _stepBtn_3.selected =NO;
            _stepBtn_3.userInteractionEnabled =YES;
            _stepBtn_4.selected =NO;
            _stepBtn_4.userInteractionEnabled =YES;
            _stepBtn_5.selected =YES;
            _stepBtn_5.userInteractionEnabled =NO;
            _stepBtn_6.selected =NO;
            _stepBtn_6.userInteractionEnabled =YES;
            [self requestQuery];
            break;
        case 6:
            _step =6;
            _stepBtn_1.selected =NO;
            _stepBtn_1.userInteractionEnabled =YES;
            _stepBtn_2.selected =NO;
            _stepBtn_2.userInteractionEnabled =YES;
            _stepBtn_3.selected =NO;
            _stepBtn_3.userInteractionEnabled =YES;
            _stepBtn_4.selected =NO;
            _stepBtn_4.userInteractionEnabled =YES;
            _stepBtn_5.selected =NO;
            _stepBtn_5.userInteractionEnabled =YES;
            _stepBtn_6.selected =YES;
            _stepBtn_6.userInteractionEnabled =NO;
            [self requestQuery];
            break;
        default:
            break;
    }
}

- (void)requestQuery {
    [_tableView setFrame:CGRectMake(0.0f, 88.0f, 320.0f, 416.0f)];
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.getThemeInformationDelegate =self;
    [manager getThemeInfoWithID:_tid :_step];
}

@end
