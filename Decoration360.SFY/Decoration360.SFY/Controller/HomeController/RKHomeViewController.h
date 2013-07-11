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
    NSArray *titleArr;
    NSArray *Arr;
    int TimeNum;
    BOOL Tend;
}

@property (retain, nonatomic) NSArray *idArray;
@property (retain, nonatomic) IBOutlet UIImageView *logoImageView;
@property (retain, nonatomic) IBOutlet UIButton *takingBtn;
@property (retain, nonatomic) IBOutlet UIButton *caseBtn;
@property (retain, nonatomic) IBOutlet UIButton *activityBtn;

@property (retain, nonatomic) IBOutlet UIImageView *bgImageView;
@property (retain, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (retain, nonatomic) IBOutlet UIButton *otherBtn;
@property (retain, nonatomic) IBOutlet UIButton *companyBtn;
@property (retain, nonatomic) IBOutlet UIButton *designerBtn;
@property (retain, nonatomic) IBOutlet UIButton *projectManagerBtn;



- (IBAction)casesBtnPressed:(id)sender;
- (IBAction)photoTalkingBtnPressed:(id)sender;
- (IBAction)projectmanagerBtnPressed:(id)sender;
- (IBAction)activityBtnPressed:(id)sender;
- (IBAction)designerBtnPressed:(id)sender;
- (IBAction)companyInfoBtnPressed:(id)sender;
- (IBAction)otherBtnPressed:(id)sender;


@end
