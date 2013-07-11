//
//  RKCaseListViewCell.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-11.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKCaseListViewCell : UITableViewCell

@property int num1;
@property int num2;
@property (retain, nonatomic) NSArray *arr;

@property (retain, nonatomic) IBOutlet UIImageView *imageView_1;
@property (retain, nonatomic) IBOutlet UIImageView *imageView_2;
@property (retain, nonatomic) IBOutlet UIButton *caseBtn_1;
@property (retain, nonatomic) IBOutlet UIButton *caseBtn_2;

- (IBAction)caseBtn_1Pressed:(id)sender;
- (IBAction)caseBtn_2Pressed:(id)sender;



@end
