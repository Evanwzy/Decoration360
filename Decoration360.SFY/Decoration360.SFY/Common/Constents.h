//
//  Constents.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-17.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#pragma mark - APP_ID
#define APP_ID @"1"
#define LOGIN_STATUS @"isLogined"
#define SN_KEY @"SN_KEY"


#pragma mark - SERVER_Adrr

//test URL
//#define SERVER_URL @"http://yijianli.com/apps"
#define SERVER_URL @"http://yijianli.cn/apps"
//#define SERVER_URL @"http://192.168.1.109/ios_apps"

#pragma mark - upload URL_Adrr
#define SharedUploadUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiTopic/add", SERVER_URL]
#define AnswerUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiComment/add", SERVER_URL]

#pragma mark - getData URL_Adrr
#define HomeUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiActive/index", SERVER_URL]
#define CommitUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiActive/index", SERVER_URL]
#define RegisterUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiLogin/regist", SERVER_URL]
#define LoginUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiLogin/login", SERVER_URL]

#define GetExpoterInfoUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiExpert/index", SERVER_URL]
#define GetThemeUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiTopic/index", SERVER_URL]
#define GetThemeDetailUrlStr [NSString stringWithFormat:@"%@/index.php?s=/ApiTopic/detailed", SERVER_URL]
#define GetCaseInfo [NSString stringWithFormat:@"%@/index.php?s=/ApiCase/index", SERVER_URL]
#define GetCompanyInfo [NSString stringWithFormat:@"%@/index.php?s=/ApiCompany/index", SERVER_URL]
#define GetActivityInfo [NSString stringWithFormat:@"%@/index.php?s=/ApiActive/activeList", SERVER_URL]
#define GetManagerList [NSString stringWithFormat:@"%@/index.php?s=/ApiProject/", SERVER_URL]

