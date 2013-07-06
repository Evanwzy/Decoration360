//
//  Common.h
//  FNO
//
//  Created by Kelly Lai on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "RKNetworkRequestManager.h"


@interface Common : NSObject{
    
}

+(NSString *)pathForPlist:(NSString *)fname;
+ (NSString *)pathForImage:(NSString *)fname;
+ (NSString *)pathForVoice:(NSString *)fname;
+ (NSString *)getTime;

+ (BOOL)isLogined;
+ (NSString *)getKey;

+ (void)checkUserDefault;

+ (NSString *)operaterStr:(NSString *)str;

//new code 12.01 ???==>about cancel request
+ (void)cancelAllRequestWithQueue:(ASINetworkQueue *)queue;
+ (void)cancelAllRequestWithQueue:(ASINetworkQueue *)queue withOutRequestWithKeys:(NSArray *)keys 
                    andWithValues:(NSArray *)values;
+ (void)cancelAllRequestWithQueue:(ASINetworkQueue *)queue withOutRequestWithDictionary:(NSDictionary *)dictionary;
+ (BOOL)requestExistsWithQueue:(ASINetworkQueue *)queue WithDictionary:(NSDictionary *)dictionary;
+ (void)cancelAllRequestOfAllQueue;

@end
