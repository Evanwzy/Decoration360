//
//  Common.m
//  FNO
//
//  Created by Kelly Lai on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Constents.h"
#import "Common.h"
#import <MessageUI/MessageUI.h>

@implementation Common

+ (NSString *)pathForPlist:(NSString *)fname {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/%@", fname];
//    return path;
//    
    NSArray *doc = NSSearchPathForDirectoriesInDomains(
                                                       
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docPath = [ doc objectAtIndex:0 ];
    
    NSString *docLocation=[docPath
                           
                           stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fname]];
    
    return docLocation;
}



+ (NSString *)pathForImage:(NSString *)fname {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/%@", fname];
    return path;
}

+ (NSString *)pathForVoice:(NSString *)fname {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/%@", fname];
    return path;
}

#pragma mark - check
+ (BOOL)isLogined {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:LOGIN_STATUS] charValue];
}

+ (NSString *)operaterStr:(NSString *)str {
    return [str substringFromIndex:3];
//    return str;
}

+(NSString *)getKey {
    NSString *key =[[NSUserDefaults standardUserDefaults] valueForKey:SN_KEY];
    return key;
}

#pragma mark - OS Time
+ (NSString *)getTime
{
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    date = [formatter stringFromDate:[NSDate date]];
    return date;
}

#pragma mark - UserDefault
+(void)checkUserDefault {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:LOGIN_STATUS];
}

#pragma mark - Cancel Request

+ (void)cancelAllRequestWithQueue:(ASINetworkQueue *)queue {
    if (queue) {
        for (ASIHTTPRequest *request in [queue operations]) {
            request.delegate = nil;
            request.didFailSelector = nil;
        }
        [queue cancelAllOperations];
    }
}

+ (void)cancelAllRequestWithQueue:(ASINetworkQueue *)queue withOutRequestWithKeys:(NSArray *)keys 
                    andWithValues:(NSArray *)values {
    if (queue) {
        if (!keys || !values) {
            [Common cancelAllRequestWithQueue:queue];
        } else if ([keys count] == [values count]) {
            for (ASIHTTPRequest *request in [queue operations]) {
                BOOL shouldCancelTheRequest = NO;
                
                if (request.userInfo) {
                    for (int i = 0; i < [keys count]; i++) {
                        NSString *key = [keys objectAtIndex:i];
                        NSString *value = [values objectAtIndex:i];
                        NSString *str = [request.userInfo objectForKey:key];
                        if (![str isEqualToString:value]) {
                            shouldCancelTheRequest = YES;
                            break;
                        }
                    }
                } else {
                    shouldCancelTheRequest = YES;
                }
                
                if (shouldCancelTheRequest) {
                    request.didFailSelector = nil;
                    request.delegate = nil;
                    [request cancel];
                }
            }
        } else {
            NSLog(@"[Common>>cancelAllRequestWithQueue:withOutKeys:andValues:]"
                  "key's count isn't equal to value's count!!!");
        }
    }
}

+ (void)cancelAllRequestWithQueue:(ASINetworkQueue *)queue withOutRequestWithDictionary:(NSDictionary *)dictionary {
    if (dictionary) {
        NSArray *keys = [dictionary allKeys];
        NSArray *values = [dictionary allValues];
        [[self class] cancelAllRequestWithQueue:queue withOutRequestWithKeys:keys andWithValues:values];
    }
}

+ (BOOL)requestExistsWithQueue:(ASINetworkQueue *)queue WithDictionary:(NSDictionary *)dictionary {
    BOOL flag = NO;
    
    if (queue) {
        if (!dictionary) {
            for (ASIHTTPRequest *request in [queue operations]) {
                if (!request.userInfo) {
                    flag = YES;
                    break;
                }
            }
        } else {
            NSArray *keys = [dictionary allKeys];
            for (ASIHTTPRequest *request in [queue operations]) {
                if (request.userInfo) {
                    flag = YES;
                    
                    for (int i = 0; i < [keys count]; i++) {
                        NSString *key = [keys objectAtIndex:i];
                        NSString *value = [dictionary objectForKey:key];
                        NSString *str = [request.userInfo objectForKey:key];
                        if (![str isEqualToString:value]) {
                            flag = NO;
                            break;
                        }
                    }
                    
                    if (!flag) {
                        break;
                    }
                }
            }
        }
    }
    
    return flag;
}

+ (void)cancelAllRequestOfAllQueue {
    RKNetworkRequestManager *networkManager = [RKNetworkRequestManager sharedManager];
//    BstDownloadManager *downloadManager = [BstDownloadManager sharedManager];
//    [[self class] cancelAllRequestWithQueue:downloadManager.queue];
    [[self class] cancelAllRequestWithQueue:networkManager.queue];
}

+ (void)setStringWithDictionary:(NSMutableDictionary *)dictionary 
                       andValue:(NSString *)value forKey:(NSString *)key {
    @try {
        if ([value isKindOfClass:NSNumber.class]) {
            [dictionary setValue:value forKey:key];
        } else if ([value isKindOfClass:NSString.class]) {
            NSString *subStr = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (value.length != 0 && key.length != 0 && subStr.length != 0) {
                [dictionary setValue:value forKey:key];
            }
        }
    } @catch (NSException *e) {
        NSLog(@"@selector(setStringWithDictionary:andValue:forKey:) throws exception: %@", e);
    }
}

+ (NSString *)weatherSubStringForFileName:(NSString *)fname {
    @try {
        NSString *subStr = [fname substringToIndex:(fname.length - 4)];
        return subStr;
    } @catch (NSException *e) {
        NSLog(@"throws exception: %@", e);
        return nil;
    }
}


//+ (void)postUpdateTimeNotification {
//    NSString *updateTimeString = [self updateTimeString];
//    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:updateTimeString forKey:kUpdateTimeKey];
//    
//    NSNotification *notification = [NSNotification notificationWithName:kUpdateTimeNotificationName object:nil userInfo:userInfo];
//    
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//}



@end
