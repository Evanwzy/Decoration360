//
//  RKtakingPhotoViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-18.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKtakingPhotoViewController : UIViewController <UIGestureRecognizerDelegate>

@property (retain, nonatomic) UIView *popView;
@property (retain, nonatomic) UIImage *image;
@property (retain, nonatomic) IBOutlet UIButton *takePhotoBtn;
@property (retain, nonatomic) IBOutlet UIButton *cancelBtn;
@property (retain, nonatomic) IBOutlet UIButton *photoBtn;

@property (retain, nonatomic) IBOutlet UIView *liveView;

- (IBAction)takePhotoBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;

@end
