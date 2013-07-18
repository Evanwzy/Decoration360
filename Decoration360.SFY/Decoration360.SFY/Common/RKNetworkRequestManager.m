//
//  RKNetworkRequestManager.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-16.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKNetworkRequestManager.h"
#import "SBJson.h"
#import "Common.h"
#import "Base64.h"
#import "Constents.h"

#define NETWORK_QUEUE_CURRENT_OPERATION 1

@implementation RKNetworkRequestManager

@synthesize queue;
@synthesize singleQueue;
@synthesize uploadSoundsDelegate, uploadImageDelegate, homeDelegate, commitDelegate, checkDelegate, getThemeInformationDelegate, getExperterInfoDelegate, sharedImageDelegate, downloadThemePicDelegate, registerDelegate , contentDelegate, caseListDelegate, activityDelegate, getManagerListDelegate;
#pragma - singleton

static RKNetworkRequestManager *_networkRequestManager;

+(RKNetworkRequestManager *)sharedManager{
    @synchronized(self){
        if (_networkRequestManager == nil) {
            _networkRequestManager = [[self alloc]init];
        }
    }
    return _networkRequestManager;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (_networkRequestManager == nil) {
            _networkRequestManager = [super allocWithZone:zone];
            return _networkRequestManager;
        }
    }
    return nil;
}

#pragma mark - getData
-(void)getHomeData {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:HomeUrlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getHomeDataDone:)];
    [request setDidFailSelector:@selector(homeQueryDatafaied:)];
    request.timeOutSeconds = 10;
//    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getHomeDataDone: (ASIHTTPRequest *)request {
//    NSLog(@"%@", [Common operaterStr:[request responseString]]);
    NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
    if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
        NSLog(@"%@", [data valueForKey:@"msg"]);
        NSArray *array =[[NSArray alloc]initWithArray:[data valueForKey:@"data"]];
        NSMutableArray *ImgStrArray = [[NSMutableArray alloc]init];
        NSMutableArray *TitleStrArray = [[NSMutableArray alloc]init];
        NSMutableArray *IdStrArray = [[NSMutableArray alloc]init];
        for (int i =0; i <[array count]; i++) {
            [IdStrArray addObject:[[array objectAtIndex:i] valueForKey:@"id"]];
            [ImgStrArray addObject:[[array objectAtIndex:i] valueForKey:@"pics"]];
            [TitleStrArray addObject:[[array objectAtIndex:i] valueForKey:@"title"]];
        }
        
        NSDictionary *homeDict =[NSDictionary dictionaryWithObjectsAndKeys:IdStrArray, @"id", ImgStrArray, @"pics", TitleStrArray, @"title", nil];
        NSString *homeDictPath  =[Common pathForPlist:@"homeDict.pilst"];
        [homeDict writeToFile:homeDictPath atomically:YES];
        [homeDelegate homeQueryData:ImgStrArray :TitleStrArray :IdStrArray];
    }
    
}

- (void)getHomeDatafailed:(ASIHTTPRequest *)request {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"本次更新失败，请检查网络"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    NSLog(@"query data error: %@", [request error]);
    [homeDelegate homeQueryDatafaied];
}

-(void)getCommitData {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:CommitUrlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getCommitDataDone:)];
    [request setDidFailSelector:@selector(commonRequestQueryDataFailed:)];
    request.timeOutSeconds = 10;
//    [request startAsynchronous];
    [queue addOperation:request];
}

-(void)getExporterInfoWithAppID {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:GetExpoterInfoUrlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getExporterInfoDone:)];
    [request setDidFailSelector:@selector(commonRequestQueryDataFailed:)];
    request.timeOutSeconds = 10;
    [queue addOperation:request];
}

- (void)getExporterInfoDone: (ASIHTTPRequest *)request {
    @try {
//        NSLog(@"%@", [Common operaterStr:[request responseString]]);
        NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
//        NSLog(@"%@", data);
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
            
            [getExperterInfoDelegate getExperterInfo:data];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
    
}

-(void)getThemeInfoFrom:(NSString *)startNum To:(NSString *)endNum {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:GetThemeUrlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request addPostValue:[NSString stringWithFormat:@"%@,%@", startNum, endNum] forKey:@"page"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getThemeInfoDone:)];
    [request setDidFailSelector:@selector(commonRequestQueryDataFailed:)];
    request.timeOutSeconds = 10;
//    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getThemeInfoWithID:(NSString *)tid :(int)step {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:GetThemeUrlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request addPostValue:tid forKey:@"pid"];
    [request addPostValue:[NSString stringWithFormat:@"%d", step] forKey:@"phase"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getThemeInfoDone:)];
    [request setDidFailSelector:@selector(commonRequestQueryDataFailed:)];
    request.timeOutSeconds = 10;
    //    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getThemeInfoDone: (ASIHTTPRequest *)request {
    @try {
//        NSLog(@"%@", [Common operaterStr:[request responseString]]);
        NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
        NSLog(@"%@", data);
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
            NSArray *a =[data valueForKey:@"data"];
            _commitNum =[a count];
//            NSLog(@"%@",a);
            [getThemeInformationDelegate themeInfoData:data];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
    
}

- (void)getCaseInfoWithStyle:(NSString *)style andSite:(NSString *)site {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:GetCaseInfo];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:@"0,10" forKey:@"page"];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request addPostValue:style forKey:@"style"];
    [request addPostValue:site forKey:@"type"];
    if ([style isEqualToString:@"全部风格"]) {
        [request addPostValue:@"0" forKey:@"style"];
    }else if ([style isEqualToString:@"简约"]) {
        [request addPostValue:@"1" forKey:@"style"];
    }else if ([style isEqualToString:@"中式"]) {
        [request addPostValue:@"2" forKey:@"style"];
    }else if ([style isEqualToString:@"欧美"]) {
        [request addPostValue:@"3" forKey:@"style"];
    }else if ([style isEqualToString:@"地中海"]) {
        [request addPostValue:@"4" forKey:@"style"];
    }else if ([style isEqualToString:@"异域"]) {
        [request addPostValue:@"5" forKey:@"style"];
    }else if ([style isEqualToString:@"混搭"]) {
        [request addPostValue:@"6" forKey:@"style"];
    }
    if ([site isEqualToString:@"全部功能"]) {
        [request addPostValue:@"0" forKey:@"type"];
    }else if ([site isEqualToString:@"厨房"]) {
        [request addPostValue:@"1" forKey:@"type"];
    }else if ([site isEqualToString:@"卫浴"]) {
        [request addPostValue:@"2" forKey:@"type"];
    }else if ([site isEqualToString:@"客厅"]) {
        [request addPostValue:@"3" forKey:@"type"];
    }else if ([site isEqualToString:@"卧室"]) {
        [request addPostValue:@"4" forKey:@"type"];
    }else if ([site isEqualToString:@"餐厅"]) {
        [request addPostValue:@"5" forKey:@"type"];
    }else if ([site isEqualToString:@"儿童房"]) {
        [request addPostValue:@"6" forKey:@"type"];
    }else if ([site isEqualToString:@"书房"]) {
        [request addPostValue:@"7" forKey:@"type"];
    }else if ([site isEqualToString:@"整体衣帽间"]) {
        [request addPostValue:@"8" forKey:@"type"];
    }else if ([site isEqualToString:@"玄关"]) {
        [request addPostValue:@"9" forKey:@"type"];
    }else if ([site isEqualToString:@"阳台阳光房"]) {
        [request addPostValue:@"10" forKey:@"type"];
    }else if ([site isEqualToString:@"楼梯"]) {
        [request addPostValue:@"11" forKey:@"type"];
    }else if ([site isEqualToString:@"储藏室"]) {
        [request addPostValue:@"12" forKey:@"type"];
    }else if ([site isEqualToString:@"其他空间"]) {
        [request addPostValue:@"13" forKey:@"type"];
    }else if ([site isEqualToString:@"户外庭院"]) {
        [request addPostValue:@"14" forKey:@"type"];
    }
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getCaseInfoDone:)];
    [request setDidFailSelector:@selector(commonRequestQueryDataFailed:)];
    request.timeOutSeconds = 10;
    //    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getCaseInfoDone :(ASIHTTPRequest *)request {
    @try {
        NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
        NSLog(@"%@", data);
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
//            NSLog(@"%@", data);
            NSLog(@"%@", [data objectForKey:@"num"]);
            [caseListDelegate caseListQueryData:data];
        }if ([[data valueForKey:@"status"] isEqualToString:@"1001"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
}

-(void)getActivityInfo {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:GetActivityInfo];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getActivityInfoDone:)];
    [request setDidFailSelector:@selector(commonRequestQueryDataFailed:)];
    request.timeOutSeconds = 10;
    //    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getActivityInfoDone: (ASIHTTPRequest *)request {
    @try {
        //        NSLog(@"%@", [Common operaterStr:[request responseString]]);
        NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
            [activityDelegate activityQueryData:[data objectForKey:@"data"]];
        }if ([[data valueForKey:@"status"] isEqualToString:@"1001"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
    
}

-(void)loginIn:(NSString *)account :(NSString *)password {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:LoginUrlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:account forKey:@"account"];
    [request addPostValue:password forKey:@"password"];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getCheckDataDone:)];
    [request setDidFailSelector:@selector(commonRequestQueryDataFailed:)];
    request.timeOutSeconds = 10;
//    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getCheckDataDone: (ASIHTTPRequest *)request {
    @try {
//        NSLog(@"%@", [Common operaterStr:[request responseString]]);
        NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
//            NSLog(@"%@", data);
            [[NSUserDefaults standardUserDefaults] setValue:[[data valueForKey:@"data"] valueForKey:@"SN_KEY"] forKey:@"SN_KEY"];
            [[NSUserDefaults standardUserDefaults] setValue:[[[data valueForKey:@"data"] valueForKey:@"user"] valueForKey:@"nickname"] forKey:@"nickname"];
            [[NSUserDefaults standardUserDefaults] setValue:[[[data valueForKey:@"data"] valueForKey:@"user"] valueForKey:@"avatar"] forKey:@"avatar"];
            [checkDelegate checkQueryData];
        }if ([[data valueForKey:@"status"] isEqualToString:@"1001"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
            [checkDelegate checkQueryDataFailed];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
}

- (void)registerID:(NSString *)account :(NSString *)password {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:RegisterUrlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:account forKey:@"account"];
    [request addPostValue:password forKey:@"password"];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getRegisterDataDone:)];
    [request setDidFailSelector:@selector(commonRequestQueryDataFailed:)];
    request.timeOutSeconds = 10;
//    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getRegisterDataDone: (ASIHTTPRequest *)request {
    @try {
//        NSLog(@"%@", [Common operaterStr:[request responseString]]);
        NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
//            NSLog(@"%@", data);
            [[NSUserDefaults standardUserDefaults] setValue:[[data valueForKey:@"data"] valueForKey:@"SN_KEY"] forKey:@"SN_KEY"];
            [[NSUserDefaults standardUserDefaults] setValue:[[data valueForKey:@"data"] valueForKey:@"nickname"] forKey:@"nickname"];
            [[NSUserDefaults standardUserDefaults] setValue:[[data valueForKey:@"data"] valueForKey:@"avatar"] forKey:@"avatar"];
            [checkDelegate checkQueryData];
        }if ([[data valueForKey:@"status"] isEqualToString:@"1001"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
            [checkDelegate checkQueryDataFailed];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
}

- (void)getContentInfo:(NSString *)tid :(NSString *)startNum :(NSString *)endNum{
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:GetThemeDetailUrlStr];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:[NSString stringWithFormat:@"%@,%@", startNum, endNum]forKey:@"page"];
    [request addPostValue:tid forKey:@"tid"];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getContentInfoDone:)];
    [request setDidFailSelector:@selector(getContentInfoFailed:)];
    request.timeOutSeconds = 10;
//    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getContentInfoDone:(ASIHTTPRequest *)request {
    @try {
//        NSLog(@"%@", [Common operaterStr:[request responseString]]);
        NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
//            NSLog(@"%@", data);
            [contentDelegate contentInfoData:[data objectForKey:@"data"]];
        }if ([[data valueForKey:@"status"] isEqualToString:@"1001"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
}

- (void)getCompanyInfo {
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    NSURL *url = [NSURL URLWithString:GetCompanyInfo];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(getCompanyInfoDone:)];
    [request setDidFailSelector:@selector(getContentInfoFailed:)];
    request.timeOutSeconds = 10;
    //    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)getCompanyInfoDone:(ASIHTTPRequest *)request {
    @try {
        //        NSLog(@"%@", [Common operaterStr:[request responseString]]);
        NSDictionary *data = [[Common operaterStr:[request responseString]] JSONValue];
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
            NSLog(@"%@", data);
        }if ([[data valueForKey:@"status"] isEqualToString:@"1001"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
}

- (void)getManagerList {
    [self checkQueue];
    NSURL *url =[NSURL URLWithString:GetManagerList];
    ASIFormDataRequest *request =[ASIFormDataRequest requestWithURL:url];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    request.delegate =self;
    request.didFinishSelector =@selector(getManagerListDone:);
    request.didFailSelector =@selector(commonRequestQueryDataFailed:);
    request.timeOutSeconds =10.0f;
    
    [queue addOperation:request];
}

- (void)getManagerListDone :(ASIHTTPRequest *)request {
    NSDictionary *data =[[Common operaterStr:[request responseString]] JSONValue];
//    NSLog(@"%@", data);
    if ([[data objectForKey:@"status"] intValue] ==0) {
        NSLog(@"%@", [data objectForKey:@"msg"]);
        [getManagerListDelegate managerListQueryData:[data objectForKey:@"data"]];
    }
}

#pragma mark - uploadRequest

//sharedTheme
- (void)sharedTheme:(NSString *)imageFile :(NSString *)mp3File {
    NSString *imgPath =[Common pathForImage:imageFile];
    NSString *mp3Path =[Common pathForVoice:mp3File];
    
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    
    
    ASIFormDataRequest *request =[self initRequestWithfile:imgPath fileName:imageFile ContentType:@"image/png" Key:@"pic_file" Url:SharedUploadUrlStr];
    [request addFile:mp3Path withFileName:mp3File andContentType:@"audio/aac" forKey:@"voice_file"];
    [request addPostValue:@"1" forKey:@"type"];
    [request addPostValue:@"0" forKey:@"pid"];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request addPostValue:@"helloWorld" forKey:@"content"];
    [request setDelegate:self];
    request.didFinishSelector =@selector(sharedThemeDone:);
    request.didFailSelector = @selector(commonRequestQueryDataFailed:);
    request.timeOutSeconds = 10;
//    [request startAsynchronous];
    [queue addOperation:request];
    
    
}

- (void)sharedTheme:(NSString *)imageFile :(NSString *)mp3File :(int)step :(NSString *)tid {
    NSString *imgPath =[Common pathForImage:imageFile];
    NSString *mp3Path =[Common pathForVoice:mp3File];
    
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    
    
    ASIFormDataRequest *request =[self initRequestWithfile:imgPath fileName:imageFile ContentType:@"image/png" Key:@"pic_file" Url:SharedUploadUrlStr];
    [request addFile:mp3Path withFileName:mp3File andContentType:@"audio/aac" forKey:@"voice_file"];
    [request addPostValue:@"1" forKey:@"type"];
    [request addPostValue:tid forKey:@"pid"];
    [request addPostValue:[NSString stringWithFormat:@"%d", step] forKey:@"phase"];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request addPostValue:@"helloWorld" forKey:@"content"];
    [request setDelegate:self];
    request.didFinishSelector =@selector(sharedThemeDone:);
    request.didFailSelector = @selector(commonRequestQueryDataFailed:);
    request.timeOutSeconds = 10;
    [queue addOperation:request];
    
    
}

- (void)sharedThemeDone:(ASIHTTPRequest *)request {
    @try {
        NSDictionary *data =[[Common operaterStr:[request responseString]] JSONValue];
        NSLog(@"%@", [data valueForKey:@"msg"]);
        [sharedImageDelegate sharedStatus];
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
}

//answerTheme
- (void)answerTheme:(NSString *)textContent :(NSString *)mp3File :(NSString *)tid {
    NSString *mp3Path =[Common pathForVoice:mp3File];
    
    [self checkQueue];
    [Common cancelAllRequestWithQueue:queue];
    
    ASIFormDataRequest *request =nil;
    if (textContent.length !=0) {
        NSURL *url =[NSURL URLWithString:AnswerUrlStr];
        request =[ASIFormDataRequest requestWithURL:url];
    }else {
        request =[self initRequestWithfile:mp3Path fileName:mp3File ContentType:@"audio/aac" Key:@"voice_file" Url:AnswerUrlStr];
    }
    [request addPostValue:textContent forKey:@"content"];
    [request addPostValue:tid forKey:@"tid"];
    [request addPostValue:APP_ID forKey:@"company"];
    [request addPostValue:[Common getKey] forKey:SN_KEY];
    [request setDelegate:self];
    request.didFinishSelector =@selector(answerThemeDone:);
    request.didFailSelector = @selector(commonRequestQueryDataFailed:);
    request.timeOutSeconds = 20;
//    [request startAsynchronous];
    [queue addOperation:request];
}

- (void)answerThemeDone:(ASIHTTPRequest *)request {
    @try {
        NSDictionary *data =[[Common operaterStr:[request responseString]] JSONValue];
        if ([[data valueForKey:@"status"] isEqualToString:@"0"]) {
            NSLog(@"%@", [data valueForKey:@"msg"]);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"[%@]%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), exception);
    }
}

-(id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(id)retain{
    return self;
}

-(unsigned)retainCount{
    return UINT_MAX;
}

-(oneway void)release{/*do nothing*/}

-(id)autorelease{
    return self;
}


#pragma mark - initRequest
- (ASIFormDataRequest *)initRequestWithfile:(NSString *)filePath fileName:(NSString *)name ContentType:(NSString *)Type Key:(NSString *)Key Url:(NSString *)UrlStr {
    NSURL *url = [NSURL URLWithString:UrlStr];   //NSLog(@"%@",url);
    //    NSURL *url = [NSURL URLWithString:@"http://192.168.1.100/ios_apps/index.php?s=/Api/video"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setFile:filePath withFileName:name andContentType:Type forKey:Key];
    return request;
}

#pragma mark - Common methods
-(void)checkQueue{
    if (!queue) {
        queue = [[ASINetworkQueue alloc]init];
        [queue setMaxConcurrentOperationCount:NETWORK_QUEUE_CURRENT_OPERATION];
        [queue setShouldCancelAllRequestsOnFailure:NO];
        
        [queue go];
    }
}

-(void)checkSingleQueue{
    if (!singleQueue) {
        singleQueue = [[ASINetworkQueue alloc]init];
        [singleQueue setMaxConcurrentOperationCount:NETWORK_QUEUE_CURRENT_OPERATION];
        [singleQueue setShouldCancelAllRequestsOnFailure:NO];
        [singleQueue go];
    }
}

-(void)checkRemoteNotificationQueue{
    if (!remoteNotificationQueue) {
        remoteNotificationQueue = [[ASINetworkQueue alloc] init];
        [remoteNotificationQueue setMaxConcurrentOperationCount:NETWORK_QUEUE_CURRENT_OPERATION];
        [remoteNotificationQueue setShouldCancelAllRequestsOnFailure:NO];
        [remoteNotificationQueue go];
    }
}

- (void)commonRequestQueryDataFailed:(ASIHTTPRequest *)request {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"本次更新失败，请检查网络"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    NSLog(@"query data error: %@", [request error]);
}

- (void)dealloc {
    if (queue) {
        [queue cancelAllOperations];
        [queue release];
    }
    
    if (remoteNotificationQueue) {
        [remoteNotificationQueue cancelAllOperations];
        [remoteNotificationQueue release];
    }
    
    if(singleQueue){
        [singleQueue cancelAllOperations];
        [singleQueue release];
    }
    
    [super dealloc];
}

#pragma mark - Common cancel

- (void)cancelAll{
    for (ASIHTTPRequest *request in [queue operations]) {
        [request cancel];
    }
}
@end
