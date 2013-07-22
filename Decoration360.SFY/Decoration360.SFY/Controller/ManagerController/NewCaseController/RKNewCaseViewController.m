//
//  RKNewCaseViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-12.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKNewCaseViewController.h"

@interface RKNewCaseViewController ()

@end

@implementation RKNewCaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *url =[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"]];
    [self.iconImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"icon_default.png"]];
    self.nameLabel.text =[[NSUserDefaults standardUserDefaults] valueForKey:@"nickname"];
    
    NSBundle *bundle = [NSBundle mainBundle];
    
	NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
	areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
	NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    province = [[NSArray alloc] initWithArray: provinceTmp];
    [provinceTmp release];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    picker =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 308, 320, 240)];
    picker.delegate =self;
    picker.dataSource =self;
    picker.showsSelectionIndicator = YES;
    [picker selectRow: 0 inComponent: 0 animated: YES];
    
    
    [self.view addSubview:picker];
    [picker setHidden:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [keyBoardController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_styleText release];
    [_nameLabel release];
    [_addrText release];
    [_roadText release];
    [_numberText release];
    [_iconImage release];
    [_provinceBtn release];
    [_cityBtn release];
    [_siteBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setStyleText:nil];
    [self setNameLabel:nil];
    [self setAddrText:nil];
    [self setRoadText:nil];
    [self setNumberText:nil];
    [self setIconImage:nil];
    [self setProvinceBtn:nil];
    [self setCityBtn:nil];
    [self setSiteBtn:nil];
    [super viewDidUnload];
}

#pragma mark - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}

#pragma mark - UIPickerDelegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (level) {
        case PROVINCE:
            return [province count];
            break;
        case CITY:
            return [city count];
            break;
        case SITE:
            return [district count];
            break;
        default:
            return 0;
            break;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (level == PROVINCE) {
        return [province objectAtIndex: row];
    }
    else if (level == CITY &&_provinceBtn.titleLabel.text.length !=0) {
        return [city objectAtIndex: row];
    }
    else if (level == SITE &&_cityBtn.titleLabel.text.length !=0){
        return [district objectAtIndex: row];
    }else {
        return 0;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (level ==PROVINCE) {
        [_provinceBtn setTitle:[province objectAtIndex:row] forState:UIControlStateNormal];
        
        selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%d", row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        [city release];
        city = [[NSArray alloc] initWithArray: array];
        [array release];
        [district release];
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
        
    }else if (level ==CITY) {
        [_cityBtn setTitle:[city objectAtIndex:row] forState:UIControlStateNormal];
        
        NSString *provinceIndex = [NSString stringWithFormat: @"%d", [province indexOfObject: selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        [district release];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
    }else {
        [_siteBtn setTitle:[district objectAtIndex:row] forState:UIControlStateNormal];
    }
}

- (void)settingToolBar {
    _toolbar =[[UIToolbar alloc]initWithFrame:CGRectMake(0, 278, 320, 30)];
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完 成", @"")
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(ButtonTap)];
    [_toolbar setItems:[NSArray arrayWithObject:doneBarItem]];
    [doneBarItem release];
    [self.view addSubview:_toolbar];
}

- (void)ButtonTap  {
    [_toolbar removeFromSuperview];
    [picker setHidden:YES];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 30)] autorelease];
    myView.textAlignment = UITextAlignmentCenter;
    if (level ==PROVINCE) {
        myView.text = [province objectAtIndex:row];
    }else if (level ==CITY) {
        myView.text = [city objectAtIndex:row];
    }else {
        myView.text = [district objectAtIndex:row];
    }
    myView.font = [UIFont systemFontOfSize:14];
    myView.backgroundColor = [UIColor clearColor];
    return myView;
}

#pragma mark - buttonAction
- (IBAction)provinceBtnPressed:(id)sender {
    [self settingToolBar];
    level =PROVINCE;
    [picker reloadAllComponents];
    [picker setHidden:NO];
}

- (IBAction)cityBtnPressed:(id)sender {
    [self settingToolBar];
    level =CITY;
    [picker reloadAllComponents];
    [picker setHidden:NO];;
}

- (IBAction)siteBtnPressed:(id)sender {
    [self settingToolBar];
    level =SITE;
    [picker reloadAllComponents];
    [picker setHidden:NO];
}

@end
