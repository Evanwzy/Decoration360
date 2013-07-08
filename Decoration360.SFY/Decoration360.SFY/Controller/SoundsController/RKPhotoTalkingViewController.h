//
//  RKPhotoTalkingViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-17.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKNetworkRequestManager.h"
#import "EGORefreshTableHeaderView.h"

@interface RKPhotoTalkingViewController : UIViewController <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource, RKRequestManagerThemeInfoDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
}

@property (retain, nonatomic)UIImageView *imgView;
@property (retain, nonatomic)UIView *contentView;

@property (retain, nonatomic)NSArray *commitArray;
@property (retain, nonatomic)NSString *commitContent_1;
@property (retain, nonatomic)NSString *commitContent_2;
@property (retain, nonatomic)NSString *commitContent_3;
@property (retain, nonatomic)NSString *commitId_1;
@property (retain, nonatomic)NSString *commitId_2;
@property (retain, nonatomic)NSString *commitId_3;
@property int themeId_1;
@property int themeId_2;
@property int themeId_3;
@property int Id;
@property (retain, nonatomic)NSString *commitVoiceUrl_1;
@property (retain, nonatomic)NSString *commitVoiceUrl_2;
@property (retain, nonatomic)NSString *commitVoiceUrl_3;

@property (retain, nonatomic)NSMutableArray *array;
@property int commentNum;
@property int countNum;
@property int requestNum;

@property (nonatomic, retain)UIImage *pic;
@property (nonatomic, retain)UIImage *icon_1;
@property (nonatomic, retain)UIImage *icon_2;
@property (nonatomic, retain)UIImage *icon_3;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

- (IBAction)uploadSoundBtnPressed:(id)sender;
- (IBAction)backBtnPressed:(id)sender;
- (IBAction)uploadImgBtnPressed:(id)sender;
@end
