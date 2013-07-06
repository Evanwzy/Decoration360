//
//  RKCommitTableViewCell.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-27.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKCommitTableViewCell : UITableViewCell


@property (retain, nonatomic) IBOutlet UIButton *nextBtn;
@property (retain, nonatomic) IBOutlet UIButton *moreBtn;
@property (retain, nonatomic) IBOutlet UIButton *commitPlayBtn;
@property (retain, nonatomic) IBOutlet UIButton *commentPlayBtn_1;
@property (retain, nonatomic) IBOutlet UIButton *commentPlayBtn_2;
@property (retain, nonatomic) IBOutlet UIButton *commentPlayBtn_3;

@property (retain, nonatomic) IBOutlet UIImageView *themeImageView;
@property (retain, nonatomic) IBOutlet UIImageView *commit_icon_1;
@property (retain, nonatomic) IBOutlet UIImageView *commit_icon_2;
@property (retain, nonatomic) IBOutlet UIImageView *commit_icon_3;
@property (retain, nonatomic) IBOutlet UITextView *commit_content_1;
@property (retain, nonatomic) IBOutlet UITextView *commit_content_2;
@property (retain, nonatomic) IBOutlet UITextView *commit_content_3;

@property int requestNum;
@property (retain, nonatomic) NSString *tid;
@property (retain, nonatomic)NSString *voiceURL;

- (IBAction)moreBtnPressed:(id)sender;
- (IBAction)nextPageBtn:(id)sender;
@end
