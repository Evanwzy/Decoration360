//
//  RKCasesViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-17.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKCasesViewController.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@implementation RKCasesViewController

@synthesize x_scrollView;
@synthesize x_pageControl;
@synthesize x_photoArray;
@synthesize x_cityRepresent;
@synthesize x_textArray;

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
    [Common cancelAllRequestOfAllQueue];
    [self requestDataQuery];
}

#pragma mark - requestDataQuery
- (void)requestDataQuery {
    if ([_type isEqualToString:@"activity"]) {
        RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
        manager.activityDelegate = self;
        [manager getActivityInfo];
    }else if ([_type isEqualToString:@"case"]) {
        
        x_photoArray =[[NSMutableArray alloc]init];
        x_textArray =[[NSMutableArray alloc]init];
        for (int i =0; i <[_arr count]; i++) {
            [x_photoArray addObject:[[_arr objectAtIndex:i] objectForKey:@"url"]];
            [x_textArray addObject:[[_arr objectAtIndex:i] objectForKey:@"info"]];
            
        }
        // 配置scrollView
        [self initScrollView];
        //创建textView
        [self createTextView];
    }
}

-(void)activityQueryData:(NSArray *)arr {
    self.arr =arr;
    x_photoArray =[[NSMutableArray alloc]init];
    x_textArray =[[NSMutableArray alloc]init];
    for (int i =0; i <[_arr count]; i++) {
        [x_photoArray addObject:[[_arr objectAtIndex:i] objectForKey:@"pics"]];
        [x_textArray addObject:[[_arr objectAtIndex:i] objectForKey:@"title"]];
    }
    // 配置scrollView
    [self initScrollView];
    //创建textView
    [self createTextView];
}

#pragma mark defined Method
// 配置scrollView
- (void)initScrollView
{
    UIScrollView *tmpScollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, 320, 320)];
    self.x_scrollView =tmpScollView;
    [tmpScollView release];
    UIColor *tmpColor =[UIColor whiteColor];
    self.x_scrollView.backgroundColor = tmpColor;
    self.x_scrollView.delegate = self;
    self.x_scrollView.pagingEnabled = YES;
    self.x_scrollView.showsHorizontalScrollIndicator = NO;
    self.x_scrollView.showsVerticalScrollIndicator = NO;
    for (int i = 0; i < [self.x_photoArray count];i++ )
    {
        UIImageView *x_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * 320,0,320,320)];
        [x_imageView setImageWithURL:[self.x_photoArray objectAtIndex:i] placeholderImage:[UIImage imageNamed:@"111.png"]];
        x_imageView.backgroundColor = [UIColor clearColor];
        [self.x_scrollView addSubview:x_imageView];
        [x_imageView release];
    }
    self.x_scrollView.contentSize = CGSizeMake(320*[self.x_photoArray count],180);
    [self.x_scrollView setContentOffset:CGPointMake(320*_num, 0)];
    [self.x_scrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.x_scrollView];
    [x_scrollView release];
    //配置pageControl
    UIPageControl *tmpPageCtr = [[UIPageControl alloc]initWithFrame:CGRectMake(130,370,60,10)];
    self.x_pageControl = tmpPageCtr;
    [tmpPageCtr release];
    x_pageControl.numberOfPages = [x_photoArray count];
    x_pageControl.currentPage = _num;
    x_pageControl.userInteractionEnabled = YES;
    x_pageControl.alpha = 1.0;
    [self.view addSubview:x_pageControl];
    [x_pageControl release];
}

//创建textView
-(void)createTextView
{
    UITextView *tmpTextView =[[UITextView alloc]initWithFrame:CGRectMake(0,390,320,80)];
    tmpTextView.backgroundColor =[UIColor clearColor];
    tmpTextView.text =[self.x_textArray objectAtIndex:_num];
    tmpTextView.editable =NO;
    self.x_cityRepresent =tmpTextView;
    [tmpTextView release];
    [self.view addSubview:x_cityRepresent];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = fabs(scrollView.contentOffset.x/320);
    if(page != x_pageControl.currentPage)
    {
        [x_pageControl setCurrentPage:page];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == x_scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		if (page != x_pageControl.currentPage)
		{
            if (page <= x_pageControl.numberOfPages) {
                x_pageControl.currentPage = page;
            }
		}
        self.x_cityRepresent.text =[self.x_textArray objectAtIndex:page];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)backBtn:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:nil];
}

@end
