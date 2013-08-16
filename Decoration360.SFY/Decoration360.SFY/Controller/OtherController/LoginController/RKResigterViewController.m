//
//  RKResigterViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-25.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKResigterViewController.h"
#import "Common.h"
#import "Constents.h"

@interface RKResigterViewController ()

@end

@implementation RKResigterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_5) {
        [_bgImage setImage:[UIImage imageNamed:@"login_bg_568.png"]];
    }else {
        [_bgImage setImage:[UIImage imageNamed:@"login_bg.png"]];
    }
    
    [_accountImg setBackgroundColor:[UIColor whiteColor]];
    [_accountImgLine setBackgroundColor:[UIColor lightGrayColor]];
    [_pwdImg setBackgroundColor:[UIColor whiteColor]];
    [_pwdImgLine setBackgroundColor:[UIColor lightGrayColor]];
    [_checkImg setBackgroundColor:[UIColor whiteColor]];
    [_checkImgLine setBackgroundColor:[UIColor lightGrayColor]];
}

-(void)viewDidAppear:(BOOL)animated {
    [Common cancelAllRequestOfAllQueue];
	[super viewWillAppear:animated];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}

-(void)viewDidDisappear:(BOOL)animated {
    [keyBoardController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_bgImage release];
    [_mailText release];
    [_accountText release];
    [_pwdText release];
    [_checkText release];
    [_checkBtn release];
    [_accountImg release];
    [_accountImgLine release];
    [_pwdImg release];
    [_pwdImgLine release];
    [_checkImg release];
    [_checkImgLine release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBgImage:nil];
    [self setMailText:nil];
    [self setAccountText:nil];
    [self setPwdText:nil];
    [self setCheckText:nil];
    [self setCheckBtn:nil];
    [self setAccountImg:nil];
    [self setAccountImgLine:nil];
    [self setPwdImg:nil];
    [self setPwdImgLine:nil];
    [self setCheckImg:nil];
    [self setCheckImgLine:nil];
    [super viewDidUnload];
}


- (IBAction)checkBtnPressed:(id)sender {
    if (![_accountText.text isEqualToString:@" 手机号"]) {
        RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
        [manager check:_accountText.text];
        
        time =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(checkBtnHid) userInfo:nil repeats:YES];
        _countNum =59;
    }
}

- (IBAction)resigterBtnPressed:(id)sender {
    if (_accountText.text.length ==0 || _pwdText.text.length ==0 || [_accountText.text isEqualToString:@" 手机号"] ||[_pwdText.text isEqualToString:@" 用户密码"] ||[_checkText.text isEqualToString:@" 验证码"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"注册信息不全！" message:@"请将信息补充完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else {
        NSString *account =_accountText.text;
        NSString *password =_pwdText.text;
        NSString *check =_checkText.text;
        
        [[RKNetworkRequestManager sharedManager] registerID:account :password :check];
        [RKNetworkRequestManager sharedManager].registerDelegate =self;
        
       
    }
}

- (IBAction)backBtnPressed:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"POPCONTROLLER" object:nil];
}

- (void)checkBtnHid {
    _checkBtn.selected =YES;
    _checkBtn.userInteractionEnabled =NO;
    if (_countNum >0) {
        [_checkBtn setTitle:[NSString stringWithFormat:@"重新发送(%d)", _countNum] forState:UIControlStateSelected];
        _countNum --;
    }else {
        _checkBtn.selected =NO;
        _checkBtn.userInteractionEnabled =YES;
        [time invalidate];
        _countNum =59;
    }
}


#pragma mark - UIKeyBoardDelegate
-(void)alttextFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag ==1) {
        _accountText.text =@"";
    }else if (textField.tag ==2) {
        _pwdText.text =@"";
    }else {
        _checkText.text =@"";
    }
}

-(void)alttextFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length ==0) {
        if (textField.tag ==1) {
            _accountText.text =@" 手机号";
        }else if (textField.tag ==2) {
            _pwdText.text =@" 用户密码";
        }else {
            _checkText.text =@" 验证码";
        }
    }
}

- (void)resigterQueryData {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGIN_STATUS];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"POPTOROOTCONTROLLER" object:nil];
}
@end
