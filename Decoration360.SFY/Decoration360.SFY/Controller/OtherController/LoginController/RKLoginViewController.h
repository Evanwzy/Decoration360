//
//  RKLoginViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-19.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "RKNetworkRequestManager.h"

@interface RKLoginViewController : UIViewController <UIKeyboardViewControllerDelegate, RKRequestManagerCheckDelegate, RKRequestManagerRegisterDelegate> {
    UIKeyboardViewController *keyBoardController;
}

@property (retain, nonatomic) IBOutlet UIButton *loginBtn;
@property (retain, nonatomic) IBOutlet UIButton *backBtn;
@property (retain, nonatomic) IBOutlet UIButton *loginOutBtn;
@property (retain, nonatomic) IBOutlet UITextField *accountText;
@property (retain, nonatomic) IBOutlet UITextField *pwdText;

- (IBAction)loginBtnPressed:(id)sender;
- (IBAction)loginOutBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)resigterBtn:(id)sender;

@end
