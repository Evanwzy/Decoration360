//
//  RKContentTableViewCell.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-2.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKContentTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIButton *playBtn;
@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;
@property (retain, nonatomic) IBOutlet UITextView *contentText;

@end
