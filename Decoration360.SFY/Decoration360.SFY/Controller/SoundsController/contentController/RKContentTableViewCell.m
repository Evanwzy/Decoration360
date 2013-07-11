//
//  RKContentTableViewCell.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-2.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKContentTableViewCell.h"

@implementation RKContentTableViewCell

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
    [_playBtn release];
    [_iconImageView release];
    [_contentText release];
    [super dealloc];
}
@end
