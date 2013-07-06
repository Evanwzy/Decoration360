//
//  RKLoginViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-19.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKLoginViewController.h"
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
    } else {
        [_loginOutBtn setHidden:YES];
        [_loginBtn setHidden:NO];
    }
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

#pragma - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}

#pragma - dataDelegate

-(void)checkQueryData {
    _accountText.text =@"";
    _pwdText.text =@"";
    [_loginBtn setHidden:YES];
    [_loginOutBtn setHidden:NO];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGIN_STATUS];
}

- (void)checkQueryDataFailed {
    _accountText.text =@"";
    _pwdText.text =@"";
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"账号或密码错误！" message:@"请重新填入账号或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)resigterQueryData {
    _accountText.text =@"";
    _pwdText.text =@"";
    [_loginBtn setHidden:YES];
    [_loginOutBtn setHidden:NO];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGIN_STATUS];
}

- (void)dealloc {
    [_accountText release];
    [_pwdText release];
    [_loginBtn release];
    [_backBtn release];
    [_loginOutBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAccountText:nil];
    [self setPwdText:nil];
    [self setLoginBtn:nil];
    [self setBackBtn:nil];
    [self setLoginOutBtn:nil];
    [super viewDidUnload];
}

#pragma mark - buttonAction
- (IBAction)loginBtnPressed:(id)sender {
    if (_accountText.text.length !=0 && _pwdText.text.length !=0) {
        NSString *account =_accountText.text;
        NSString *password =_pwdText.text;
        
        [[RKNetworkRequestManager sharedManager] loginIn:account :password];
        [RKNetworkRequestManager sharedManager].checkDelegate =self;
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"账号或密码为空！" message:@"请填入账号或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)loginOutBtnPressed:(id)sender {
    [_loginBtn setHidden:NO];
    [_loginOutBtn setHidden:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:LOGIN_STATUS];
}

- (IBAction)backBtnPressed:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:nil];
}

- (IBAction)resigterBtn:(id)sender {
    if (_accountText.text.length !=0 && _pwdText.text.length !=0) {
        NSString *account =_accountText.text;
        NSString *password =_pwdText.text;
        
        [[RKNetworkRequestManager sharedManager] registerID:account :password];
        [RKNetworkRequestManager sharedManager].registerDelegate =self;
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"账号或密码为空！" message:@"请填入账号或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

@end
