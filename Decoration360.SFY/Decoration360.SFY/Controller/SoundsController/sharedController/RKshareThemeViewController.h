//
//  RKshareThemeViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-20.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKNetworkRequestManager.h"

@interface RKshareThemeViewController : UIViewController <RKRequestManagerExperterInfoDelegate, RKRequestManagerSharedImageDelegate>

@property (retain, nonatomic) NSString *imageFile;
@property (retain ,nonatomic  ) NSString *mp3File;

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)sharedBtnPressed:(id)sender;
@end
