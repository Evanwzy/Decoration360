//
//  RKNewCaseViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-7-12.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define SITE_COMPONENT      2

@interface RKNewCaseViewController : UIViewController {
    UIPickerView *picker;
    UIButton *button;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}
@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) UIButton *button;

@property (nonatomic, retain) NSDictionary *areaDic;
@property (nonatomic, retain) NSArray *province;
@property (nonatomic, retain) NSArray *city;
@property (nonatomic, retain) NSArray *district;

@property (nonatomic, retain) NSString *selectedProvince;

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
