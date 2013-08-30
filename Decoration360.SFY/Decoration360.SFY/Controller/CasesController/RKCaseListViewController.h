//
//  RKCaseListViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-5.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "RKNetworkRequestManager.h"

@interface RKCaseListViewController : UIViewController <NIDropDownDelegate, RKRequestManagerCaseListDelegate,UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UIButton *btnStyle;
    IBOutlet UIButton *btnSite;

    NIDropDown *dropDown;
    NIDropDown *dropDown2;
}

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSArray *dataArray;
@property int num;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIButton *btnStyle;
@property (retain, nonatomic) IBOutlet UIButton *btnSite;

- (IBAction)btnStyleClicked:(id)sender;
- (IBAction)btnSiteClicked:(id)sender;
- (IBAction)backPressed:(id)sender;

@end
