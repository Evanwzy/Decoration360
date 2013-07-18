//
//  RKCheckingDesignerViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-18.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKCheckingDesignerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic)NSArray *dataArr;
@property int num;

@property (retain, nonatomic)UITableView *tableView;

- (IBAction)backBtn:(id)sender;
@end
