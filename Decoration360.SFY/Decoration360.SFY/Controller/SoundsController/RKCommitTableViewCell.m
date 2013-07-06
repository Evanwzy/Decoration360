//
//  RKCommitTableViewCell.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-27.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKCommitTableViewCell.h"
#import "RKContentViewController.h"

@implementation RKCommitTableViewCell

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


- (void)dealloc
{
    [_moreBtn release];
    [_commitPlayBtn release];
    [_commentPlayBtn_1 release];
    [_commentPlayBtn_2 release];
    [_commentPlayBtn_3 release];
    
    [_themeImageView release];
    [_commit_icon_1 release];
    [_commit_icon_2 release];
    [_commit_icon_3 release];
    
    [_commit_content_1 release];
    [_commit_content_2 release];
    [_commit_content_3 release];
    
    [_nextBtn release];
    [super dealloc];
}

- (IBAction)moreBtnPressed:(id)sender {
    RKContentViewController *contentCtr =[[RKContentViewController alloc]init];
    contentCtr.tid =_tid;
    contentCtr.picImage =_themeImageView.image;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:contentCtr];
    [contentCtr release];
}

- (IBAction)nextPageBtn:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ADDREQUESTNUM" object:nil];
}
@end
