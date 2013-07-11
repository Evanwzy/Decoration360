//
//  RKCaseListViewCell.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-11.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKCaseListViewCell.h"
#import "RKCasesViewController.h"

@implementation RKCaseListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_imageView_1 release];
    [_imageView_2 release];
    [_caseBtn_1 release];
    [_caseBtn_2 release];
    [super dealloc];
}
- (IBAction)caseBtn_1Pressed:(id)sender {
    RKCasesViewController *cvCtr =[[RKCasesViewController alloc]init];
    cvCtr.num =_num1;
    cvCtr.arr =_arr;
    cvCtr.type =@"case";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:cvCtr];
}

- (IBAction)caseBtn_2Pressed:(id)sender {
    RKCasesViewController *cvCtr =[[RKCasesViewController alloc]init];
    cvCtr.num =_num2;
    cvCtr.arr =_arr;
    cvCtr.type =@"case";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:cvCtr];
}
@end
