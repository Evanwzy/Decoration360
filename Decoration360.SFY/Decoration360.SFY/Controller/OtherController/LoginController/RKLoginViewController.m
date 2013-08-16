//
//  RKLoginViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-19.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKLoginViewController.h"
#import "RKResigterViewController.h"
#import "Common.h"
#import "Constents.h"

@interface RKLoginViewController ()

@end

@implementation RKLoginViewController

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
    
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.checkDelegate =self;
    
    if ([Common isLogined]) {
        [_loginBtn setHidden:YES];
        [_loginOutBtn setHidden:NO];
        [_pwdText setHidden:YES];
        [_accountText setHidden:YES];
        [_accountImg setHidden:YES];
        [_accountImgLine setHidden:YES];
        [_pwdImg setHidden:YES];
        [_pwdImgline setHidden:YES];
    } else {
        [_loginOutBtn setHidden:YES];
        [_loginBtn setHidden:NO];
    }
    
    if (IS_IPHONE_5) {
        _bgImage.image =[UIImage imageNamed:@"login_bg_568.png"];
    } else {
        _bgImage.image =[UIImage imageNamed:@"login_bg.png"];
    }
    
    [_accountImg setBackgroundColor:[UIColor whiteColor]];
    [_accountImgLine setBackgroundColor:[UIColor lightGrayColor]];
    [_pwdImg setBackgroundColor:[UIColor whiteColor]];
    [_pwdImgline setBackgroundColor:[UIColor lightGrayColor]];
}

-(void)viewWillAppear:(BOOL)animated {
    [Common cancelAllRequestOfAllQueue];
	[super viewWillAppear:animated];
	keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[keyBoardController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
    if (textField.text.length ==0) {
        if (textField.tag ==1) {
            _accountText.text =@" 手机号";
        }else {
            _pwdText.text =@" 用户密码";
        }
    }
}
-(void)alttextFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag ==1) {
        _accountText.text =@"";
    }else {
        _pwdText.text =@"";
    }
}


#pragma mark - dataDelegate

-(void)checkQueryData {
    _accountText.text =@" 手机号";
    _pwdText.text =@" 用户密码";
    [_loginBtn setHidden:YES];
    [_loginOutBtn setHidden:NO];
    [_loginBtn setHidden:YES];
    [_loginOutBtn setHidden:NO];
    [_pwdText setHidden:YES];
    [_accountText setHidden:YES];
    [_accountImg setHidden:YES];
    [_accountImgLine setHidden:YES];
    [_pwdImg setHidden:YES];
    [_pwdImgline setHidden:YES];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGIN_STATUS];
}

- (void)checkQueryDataFailed {
    _accountText.text =@" 手机号";
    _pwdText.text =@" 用户密码";
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"账号或密码错误！" message:@"请重新填入账号或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)dealloc {
    [_accountText release];
    [_pwdText release];
    [_loginBtn release];
    [_backBtn release];
    [_loginOutBtn release];
    [_bgImage release];
    [_accountLabel release];
    [_pwdLabel release];
    [_pwdImg release];
    [_accountImg release];
    [_pwdImgline release];
    [_accountImgLine release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAccountText:nil];
    [self setPwdText:nil];
    [self setLoginBtn:nil];
    [self setBackBtn:nil];
    [self setLoginOutBtn:nil];
    [self setBgImage:nil];
    [self setAccountLabel:nil];
    [self setPwdLabel:nil];
    [self setPwdImg:nil];
    [self setAccountImg:nil];
    [self setPwdImgline:nil];
    [self setAccountImgLine:nil];
    [super viewDidUnload];
}

#pragma mark - buttonAction
- (IBAction)loginBtnPressed:(id)sender {
    if (_accountText.text.length ==0 || _pwdText.text.length ==0 ||[_accountText.text isEqualToString:@" 手机号"] ||[_pwdText.text isEqualToString:@" 用户密码"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"账号或密码为空！" message:@"请填入账号或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else {
        NSString *account =_accountText.text;
        NSString *password =_pwdText.text;
        
        [[RKNetworkRequestManager sharedManager] loginIn:account :password];
        [RKNetworkRequestManager sharedManager].checkDelegate =self;
        
    }
}

- (IBAction)loginOutBtnPressed:(id)sender {
    [_loginBtn setHidden:NO];
    [_loginOutBtn setHidden:YES];
    [_accountImg setHidden:NO];
    [_accountImgLine setHidden:NO];
    [_pwdImg setHidden:NO];
    [_pwdImgline setHidden:NO];
    [_accountText setHidden:NO];
    [_pwdText setHidden:NO];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:LOGIN_STATUS];
}

- (IBAction)backBtnPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:nil];
}

- (IBAction)resigterBtn:(id)sender {
    RKResigterViewController *rvCtr =[[RKResigterViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:rvCtr];
    [rvCtr release];
}

@end
