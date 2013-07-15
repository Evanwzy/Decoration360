//
//  RKNewCaseViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-12.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "UIImageView+WebCache.h"


typedef NS_ENUM(NSInteger, Level){
    PROVINCE,
    CITY,
    SITE,
};

@interface RKNewCaseViewController : UIViewController<UIKeyboardViewControllerDelegate, UIPickerViewDelegate,  UIPickerViewDataSource> {
    UIKeyboardViewController *keyBoardController;
    
    UIPickerView *picker;
    UIButton *button;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
    
    int level;
}
@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) UIButton *button;

@property (nonatomic, retain) NSDictionary *areaDic;
@property (nonatomic, retain) NSArray *province;
@property (nonatomic, retain) NSArray *city;
@property (nonatomic, retain) NSArray *district;

@property int provinceRow;
@property int cityRow;
@property int districtRow;

@property (nonatomic, retain) NSString *selectedProvince;

@property (nonatomic, retain) UIToolbar *toolbar;

@property (retain, nonatomic) IBOutlet UIButton *provinceBtn;
@property (retain, nonatomic) IBOutlet UIButton *cityBtn;
@property (retain, nonatomic) IBOutlet UIButton *siteBtn;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UIImageView *iconImage;
@property (retain, nonatomic) IBOutlet UITextField *styleText;
@property (retain, nonatomic) IBOutlet UITextField *addrText;
@property (retain, nonatomic) IBOutlet UITextField *roadText;
@property (retain, nonatomic) IBOutlet UITextField *numberText;


- (IBAction)provinceBtnPressed:(id)sender;
- (IBAction)cityBtnPressed:(id)sender;
- (IBAction)siteBtnPressed:(id)sender;


@end
