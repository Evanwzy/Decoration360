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
#import "UIButton+WebCache.h"

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
    
//    // 初始化自定义ScrollView类对象
//    AOScrollerView *aSV = [[AOScrollerView alloc]initWithNameArr:imageArray titleArr:titleArray height:88];
//    //设置委托
//    aSV.vDelegate=self;
//    //添加进view
//    [self.view addSubview:aSV];
    
    if (!page) {
        page =[[UIPageControl alloc]init];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    Arr=[[NSArray alloc]initWithArray:imageArray];
    titleArr =[[NSArray alloc]initWithArray:titleArray];
    [self AdImg:Arr];
    [self setCurrentPage:page.currentPage];
    
    [self setUI];
}

- (void)homeQueryDatafaied {
    [self setUI];
}

-(void)buttonClick:(int)vid {
    NSLog(@"%d", vid);
}

#pragma mark - 5秒换图片
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 5 == 0 ) {
        
        if (!Tend) {
            page.currentPage++;
            if (page.currentPage==page.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            page.currentPage--;
            if (page.currentPage==0) {
                Tend=NO;
            }
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             sv.contentOffset = CGPointMake(page.currentPage*320,0);
                         }];
        
        
    }
    TimeNum ++;
}

#pragma mark - 下载图片
void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
{
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                   {
                       NSData * data = [[NSData alloc] initWithContentsOfURL:URL] ;
                       UIImage * image = [[UIImage alloc] initWithData:data];
                       dispatch_async( dispatch_get_main_queue(), ^(void){
                           if( image != nil )
                           {
                               imageBlock( image );
                           } else {
                               errorBlock();
                           }
                       });
                   });
}

-(void)AdImg:(NSArray*)arr{
    [sv setContentSize:CGSizeMake(320*[arr count], 80)];
    page.numberOfPages=[arr count];
    
    for ( int i=0; i<[arr count]; i++) {
        NSString *url=[arr objectAtIndex:i];
        UIButton *img=[[UIButton alloc]initWithFrame:CGRectMake(320*i, 0, 320, 80)];
        [img addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
        [img setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
        
        UILabel *adLabel =[[UILabel alloc]initWithFrame:CGRectMake(320*i, 60, 320, 20)];
        adLabel.text =[titleArr objectAtIndex:i];
        adLabel.alpha =0.4;
        adLabel.backgroundColor =[UIColor blackColor];
        adLabel.textColor =[UIColor whiteColor];
        
        [sv addSubview:img];
        [sv addSubview:adLabel];

//        UIImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
//                       {
//                           [img setImage:image forState:UIControlStateNormal];
//                       }, ^(void){
//                       });
    }
    
}

-(void)Action{
    
    NSString *theTitle = [NSString stringWithString:[titleArr objectAtIndex:page.currentPage]];
    NSLog(@"%@", theTitle);
}

#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    page.currentPage=scrollView.contentOffset.x/320;
    [self setCurrentPage:page.currentPage];
    
    
}
- (void) setCurrentPage:(NSInteger)secondPage {
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [page.subviews count]; subviewIndex++) {
        UIImageView* subview = [page.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 24/2;
        size.width = 24/2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"a.png"]];
        else [subview setImage:[UIImage imageNamed:@"d.png"]];
    }
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
