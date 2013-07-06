//
//  RKCommitContentView.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-20.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKCommitContentView.h"

@implementation RKCommitContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_themeImageView release];
    [_commit_icon_1 release];
    [_commit_content_1 release];
    [_commit_icon_2 release];
    [_commit_icon_3 release];
    [_commit_content_2 release];
    [_commit_content_3 release];
    [_moreBtn release];
    [_commitPlayBtn release];
    [_commentPlayBtn_1 release];
    [_commentPlayBtn_2 release];
    [_commentPlayBtn_3 release];
    [super dealloc];
}
- (IBAction)moreBtn:(id)sender {
}
@end
