//
//  RKNetworkRequestManager.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-16.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"

@protocol RKRequestManagerUploadSoundsDelegate;
@protocol RKRequestManagerUploadImageDelegate;
@protocol RKRequestManagerSharedImageDelegate;

@protocol RKRequestManagerHomeDelegate;
@protocol RKRequestManagerCommitDelegate;
@protocol RKRequestManagerCheckDelegate;
@protocol RKRequestManagerRegisterDelegate;
@protocol RKRequestManagerCaseListDelegate;

@protocol RKRequestManagerExperterInfoDelegate;
@protocol RKRequestManagerThemeInfoDelegate;

@protocol RKRequestManagerDownloadThemePicDelegate;

@interface RKNetworkRequestManager : NSObject {
    ASINetworkQueue *queue;
    ASINetworkQueue *singleQueue;
    ASINetworkQueue *remoteNotificationQueue;
    //NSOperationQueue *queue;
    
    //Delegate
    id<RKRequestManagerUploadSoundsDelegate> uploadSoundsDelegate;
    id<RKRequestManagerUploadImageDelegate> uploadImageDelegate;
    id<RKRequestManagerSharedImageDelegate> sharedImageDelegate;
    
    id<RKRequestManagerHomeDelegate> homeDelegate;
    id<RKRequestManagerCommitDelegate> commitDelegate;
    id<RKRequestManagerCheckDelegate> checkDelegate;
    id<RKRequestManagerRegisterDelegate> registerDelegate;
    id<RKRequestManagerCaseListDelegate> caseListDelegate;
    
    id<RKRequestManagerExperterInfoDelegate> getExperterInfoDelegate;
    id<RKRequestManagerThemeInfoDelegate> getThemeInformationDelegate;
    
    id<RKRequestManagerDownloadThemePicDelegate> downloadThemePicDelegate;
}

@property (nonatomic, retain) ASINetworkQueue *queue;
@property (nonatomic, retain) ASINetworkQueue *singleQueue;


@property (nonatomic, assign) id<RKRequestManagerUploadSoundsDelegate> uploadSoundsDelegate;
@property (nonatomic, assign) id<RKRequestManagerUploadImageDelegate> uploadImageDelegate;
@property (nonatomic, assign) id<RKRequestManagerSharedImageDelegate> sharedImageDelegate;

@property (nonatomic, assign) id<RKRequestManagerHomeDelegate> homeDelegate;
@property (nonatomic, assign) id<RKRequestManagerCommitDelegate> commitDelegate;
@property (nonatomic, assign) id<RKRequestManagerCheckDelegate> checkDelegate;
@property (nonatomic, assign) id<RKRequestManagerCaseListDelegate> caseListDelegate;

@property (nonatomic, assign) id<RKRequestManagerRegisterDelegate> registerDelegate;

@property (nonatomic,assign) id<RKRequestManagerExperterInfoDelegate> getExperterInfoDelegate;
@property (nonatomic, assign) id<RKRequestManagerThemeInfoDelegate> getThemeInformationDelegate;

@property (nonatomic, assign) id<RKRequestManagerDownloadThemePicDelegate> downloadThemePicDelegate;


@property (nonatomic, retain)NSURL *picUrl;
@property (nonatomic, retain)NSURL *iconUrl_1;
@property (nonatomic, retain)NSURL *iconUrl_2;
@property (nonatomic, retain)NSURL *iconUrl_3;
@property (nonatomic, retain)NSURL *voiceUrl;

@property (nonatomic, retain)UIImage *pic;
@property (nonatomic, retain)UIImage *icon_1;
@property (nonatomic, retain)UIImage *icon_2;
@property (nonatomic, retain)UIImage *icon_3;

@property int commitNum;
@property int commentNum;
@property int num;
@property (retain, nonatomic) NSMutableArray *arrNum;

+ (RKNetworkRequestManager*)sharedManager;


//uploadData
- (void)sharedTheme:(NSString *)imageFile :(NSString *)mp3File;
- (void)answerTheme:(NSString *)textContent :(NSString *)mp3File :(NSString *)tid;
- (void)loginIn:(NSString *)account :(NSString *)password;
- (void)registerID:(NSString *)account :(NSString *)password;

- (void)uploadSounds;
- (void)uploadImg;

//getData
- (void)getHomeData;
- (void)getCommitData;
-(void)getThemeInfoFrom:(NSString *)startNum To:(NSString *)endNum;
- (void)getExporterInfoWithAppID;
- (void)getContentInfo:(NSString *)tid :(NSString *)startNum :(NSString *)endNum;
- (void)getCaseInfoWithStyle:(NSString *)style andSite:(NSString *)site;


//downLoadData
- (void)downloadThemeWithPicUrl:(NSString *)url1 iconUrl_1:(NSString *)url2 iconUrl_2:(NSString *)url3 iconUrl_3:(NSString *)url4 andVoiceUrl:(NSString *)url5 Num:(int)commentNum;
@end

#pragma protocol

@protocol uploadSoundsRequestDelegate <NSObject>

- (void)uploadSoundsFinish;

@end

@protocol uploadImageDelegate <NSObject>

- (void)uploadImageDelegate;

@end

@protocol RKRequestManagerSharedImageDelegate <NSObject>

- (void)sharedStatus;

@end

@protocol RKRequestManagerHomeDelegate <NSObject>

@optional
- (void)homeQueryData:(NSMutableArray *)imageArray :(NSMutableArray *)titleArray;
- (void)homeQueryDatafaied;

@end

@protocol RKRequestManagerCommitDelegate <NSObject>

- (void)commitQueryData;

@end

@protocol RKRequestManagerCheckDelegate <NSObject>

- (void)checkQueryData;
- (void)checkQueryDataFailed;

@end

@protocol RKRequestManagerRegisterDelegate <NSObject>

- (void)resigterQueryData;

@end

@protocol RKRequestManagerCaseListDelegate <NSObject>

- (void)caseListQueryData:(NSArray *)arr;

@end

@protocol RKRequestManagerExperterInfoDelegate <NSObject>

- (void) getExperterInfo:(NSArray *)expertInfo;

@end

@protocol RKRequestManagerThemeInfoDelegate <NSObject>

- (void)themeInfoData:(NSDictionary *)a;

@end



@protocol RKRequestManagerDownloadThemePicDelegate <NSObject>

- (void)downloadThemePicData:(UIImage *)pic :(int)num;
- (void)downloadThemePicData:(UIImage *)pic iocn_1:(UIImage *)icon_1 :(int)num;
- (void)downloadThemePicData:(UIImage *)pic iocn_1:(UIImage *)icon_1 iocn_2:(UIImage *)icon_2 :(int)num;
- (void)downloadThemePicData:(UIImage *)pic iocn_1:(UIImage *)icon_1 iocn_2:(UIImage *)icon_2 iocn_3:(UIImage *)icon_3 :(int)num;

@end
