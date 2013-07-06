//
//  RKCasesViewController.h
//  Decoration360.SFY
//
//  Created by Evan on 13-6-17.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface RKCasesViewController : UIViewController <NIDropDownDelegate, UIScrollViewDelegate> {
    IBOutlet UIButton *btnSelect;
    IBOutlet UIButton *siteBtnClicked;
    NIDropDown *dropDwon;
    
    UIScrollView              *x_scrollView;
    UIPageControl             *x_pageControl;
    NSMutableArray            *x_photoArray;
    UITextView                *x_cityRepresent;
    NSMutableArray            *x_textArray;
}

@property (nonatomic,retain)UIScrollView          *x_scrollView;
@property (nonatomic,retain)UIPageControl         *x_pageControl;
@property (nonatomic,retain)NSMutableArray        *x_photoArray;
@property (nonatomic,retain)UITextView            *x_cityRepresent;
@property (nonatomic,retain)NSMutableArray        *x_textArray;

@property (retain, nonatomic) IBOutlet UIButton *styleBtn;
@property (retain, nonatomic) IBOutlet UIButton *siteBtn;
@property (retain, nonatomic) IBOutlet UIButton *btnSelect;
@property (retain, nonatomic) IBOutlet UIButton *siteBtnClicked;


- (IBAction)siteBtnClicked:(id)sender;
- (IBAction)selectClicked:(id)sender;

- (IBAction)backBtn:(id)sender;

@end
