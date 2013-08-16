//
//  RKResigterViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-25.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <time.h>
#import "RKNetworkRequestManager.h"
#import "UIKeyboardViewController.h"

@interface RKResigterViewController : UIViewController <RKRequestManagerRegisterDelegate, UIKeyboardViewControllerDelegate> {
    UIKeyboardViewController *keyBoardController;
    NSTimer *time;
}
@property int countNum;

@property (retain, nonatomic) IBOutlet UIImageView *accountImg;
@property (retain, nonatomic) IBOutlet UIImageView *accountImgLine;
@property (retain, nonatomic) IBOutlet UIImageView *pwdImg;
@property (retain, nonatomic) IBOutlet UIImageView *pwdImgLine;
@property (retain, nonatomic) IBOutlet UIImageView *checkImg;
@property (retain, nonatomic) IBOutlet UIImageView *checkImgLine;

@property (retain, nonatomic) IBOutlet UIImageView *bgImage;
@property (retain, nonatomic) IBOutlet UIButton *checkBtn;
@property (retain, nonatomic) IBOutlet UITextField *mailText;
@property (retain, nonatomic) IBOutlet UITextField *accountText;
@property (retain, nonatomic) IBOutlet UITextField *pwdText;
@property (retain, nonatomic) IBOutlet UITextField *checkText;

- (IBAction)checkBtnPressed:(id)sender;
- (IBAction)resigterBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;

@end
