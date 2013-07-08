//
//  RKHomeViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-16.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AOScrollerView.h"
#import "RKNetworkRequestManager.h"

@interface RKHomeViewController : UIViewController < RKRequestManagerHomeDelegate> {
    IBOutlet UIScrollView *sv;
    UIPageControl *page;
    IBOutlet UIWebView *wb;
    NSArray *Arr;
    NSArray *titleArr;
    int TimeNum;
    BOOL Tend;
}
@property (retain, nonatomic) IBOutlet UIButton *takingBtn;
@property (retain, nonatomic) IBOutlet UIButton *caseBtn;

@property (retain, nonatomic) IBOutlet UIImageView *bgImageView;
@property (retain, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (retain, nonatomic) IBOutlet UIButton *otherBtn;



- (IBAction)casesBtnPressed:(id)sender;
- (IBAction)photoTalkingBtnPressed:(id)sender;
- (IBAction)projectmanagerBtnPressed:(id)sender;
- (IBAction)activityBtnPressed:(id)sender;
- (IBAction)designerBtnPressed:(id)sender;
- (IBAction)companyInfoBtnPressed:(id)sender;
- (IBAction)otherBtnPressed:(id)sender;


@end
