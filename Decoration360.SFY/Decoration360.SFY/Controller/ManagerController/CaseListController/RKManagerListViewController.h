//
//  RKManagerListViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-12.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKNetworkRequestManager.h"

@interface RKManagerListViewController : UIViewController<RKRequestManagerManagerListDelegate, UITableViewDelegate, UITableViewDataSource>
@property int num;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSArray *dataArray;

- (IBAction)newBtnPressed:(id)sender;
- (IBAction)backBtn:(id)sender;
@end
