//
//  RKManagerListViewCell.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-15.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKManagerListViewCell.h"

@implementation RKManagerListViewCell

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
    [_nameLabel release];
    [_addrLabel release];
    [super dealloc];
}
@end
