//
//  RKshareThemeViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-6-20.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKshareThemeViewController.h"
#import "RKtakingPhotoViewController.h"
#import "RKPhotoTalkingViewController.h"
#import "RKCheckingDesignerViewController.h"
#import "RKHomeViewController.h"
#import "Common.h"
#import "UIButton+WebCache.h"

@interface RKshareThemeViewController ()

@end

@implementation RKshareThemeViewController

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
    
    [_deleteImg1 setHidden:YES];
    [_deleteImg2 setHidden:YES];
    [_deleteImg3 setHidden:YES];
    [_deleteImg4 setHidden:YES];
    [_deleteImg5 setHidden:YES];
    [_deleteImg6 setHidden:YES];
    [_deleteImg7 setHidden:YES];
    [_deleteImg8 setHidden:YES];
    
    [Common cancelAllRequestOfAllQueue];
    RKNetworkRequestManager *manager=[RKNetworkRequestManager sharedManager];
    manager.getExperterInfoDelegate =self;
    [manager getExporterInfoWithAppID];
    
    _selectedDesigner =[[NSMutableArray alloc]init];
    _btnTag =0;
    _dTag=0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableAction:) name:@"SELECTEDCELL" object:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [self setupUI];
    
    [_takePicBtn setImage:[UIImage imageWithContentsOfFile:[Common pathForImage:[_imageFile stringByAppendingFormat:@".png"]]] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setBtnAction {
    
}




- (IBAction)sharedBtnPressed:(id)sender {
    RKNetworkRequestManager *manager=[RKNetworkRequestManager sharedManager];
    
    manager.sharedImageDelegate =self;
    
    if (_type ==PROJECT) {
        [manager sharedTheme:[_imageFile stringByAppendingFormat:@".png"] :[_mp3File stringByAppendingFormat:@".aac"] :_step :_tid];
    }else {
        [manager sharedTheme:[_imageFile stringByAppendingFormat:@".png"] :[_mp3File stringByAppendingFormat:@".aac"] ];
    }
}

- (IBAction)takePic:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPTOROOTCONTROLLER" object:nil];
}

- (IBAction)addDesignerBtn:(id)sender {
    UIButton *button =sender;
    if (button.tag ==_btnTag) {
        RKCheckingDesignerViewController *dvCtr=[[RKCheckingDesignerViewController alloc] init];
        dvCtr.dataArr =_designerData;
        [self presentModalViewController:dvCtr animated:YES];
    }else if (button.tag ==_btnTag+1 &&_btnTag !=0) {
        _dTag =1;
        switch (_btnTag) {
                
            case 1:
                [_deleteImg1 setHidden:NO];
                break;
            case 2:
                [_deleteImg1 setHidden:NO];
                [_deleteImg2 setHidden:NO];
                break;
            case 3:
                [_deleteImg1 setHidden:NO];
                [_deleteImg2 setHidden:NO];
                [_deleteImg3 setHidden:NO];
                break;
            case 4:
                [_deleteImg1 setHidden:NO];
                [_deleteImg2 setHidden:NO];
                [_deleteImg3 setHidden:NO];
                [_deleteImg4 setHidden:NO];
                break;
            case 5:
                [_deleteImg1 setHidden:NO];
                [_deleteImg2 setHidden:NO];
                [_deleteImg3 setHidden:NO];
                [_deleteImg4 setHidden:NO];
                [_deleteImg5 setHidden:NO];
                break;
            case 6:
                [_deleteImg1 setHidden:NO];
                [_deleteImg2 setHidden:NO];
                [_deleteImg3 setHidden:NO];
                [_deleteImg4 setHidden:NO];
                [_deleteImg5 setHidden:NO];
                [_deleteImg6 setHidden:NO];
                break;
            default:
                break;
        }
    }else if (button.tag <_btnTag && _dTag ==1) {
        _dTag =0;
        [_designerData addObject:[_selectedDesigner objectAtIndex:button.tag]];
        [_selectedDesigner removeObjectAtIndex:button.tag];
        _btnTag =_btnTag -1;
        [self setupUI];
        [_deleteImg1 setHidden:YES];
        [_deleteImg2 setHidden:YES];
        [_deleteImg3 setHidden:YES];
        [_deleteImg4 setHidden:YES];
        [_deleteImg5 setHidden:YES];
        [_deleteImg6 setHidden:YES];
        [_deleteImg7 setHidden:YES];
        [_deleteImg8 setHidden:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SELECTEDCELL" object:nil];
    
    [_imageView release];
    [_takePicBtn release];
    [_designerImg1 release];
    [_designerImg2 release];
    [_designerImg3 release];
    [_designerImg4 release];
    [_designerImg5 release];
    [_designerImg6 release];
    [_designerImg7 release];
    [_designerImg8 release];
    [_deleteImg1 release];
    [_deleteImg2 release];
    [_deleteImg3 release];
    [_deleteImg4 release];
    [_deleteImg5 release];
    [_deleteImg6 release];
    [_deleteImg7 release];
    [_deleteImg8 release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setTakePicBtn:nil];
    [self setDesignerImg1:nil];
    [self setDesignerImg2:nil];
    [self setDesignerImg3:nil];
    [self setDesignerImg4:nil];
    [self setDesignerImg5:nil];
    [self setDesignerImg6:nil];
    [self setDesignerImg7:nil];
    [self setDesignerImg8:nil];
    [self setDeleteImg1:nil];
    [self setDeleteImg2:nil];
    [self setDeleteImg3:nil];
    [self setDeleteImg4:nil];
    [self setDeleteImg5:nil];
    [self setDeleteImg6:nil];
    [self setDeleteImg7:nil];
    [self setDeleteImg8:nil];
    [super viewDidUnload];
}

-(void)getExperterInfo:(NSDictionary *)expertInfo {
    self.designerData =[expertInfo objectForKey:@"data"];
}

-(void)sharedStatus {
    RKHomeViewController *hvCtr =[[RKHomeViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPTOROOTCONTROLLER" object:hvCtr];
    [hvCtr release];
}

- (void)setupUI {
    self.navigationController.navigationBarHidden =YES;
    [_designerImg1 setImage:nil forState:UIControlStateNormal];
    [_designerImg2 setImage:nil forState:UIControlStateNormal];
    [_designerImg3 setImage:nil forState:UIControlStateNormal];
    [_designerImg4 setImage:nil forState:UIControlStateNormal];
    [_designerImg5 setImage:nil forState:UIControlStateNormal];
    [_designerImg6 setImage:nil forState:UIControlStateNormal];
    [_designerImg7 setImage:nil forState:UIControlStateNormal];
    [_designerImg8 setImage:nil forState:UIControlStateNormal];
    switch (_btnTag) {
        case 0:
            [_designerImg1 setImage:[UIImage imageNamed:@"plus_icon.png"] forState:UIControlStateNormal];
            [_designerImg2 setImage:[UIImage imageNamed:@"minuse_icon.png"] forState:UIControlStateNormal];
            break;
        case 1:
            [_designerImg1 setImageWithURL:[[_selectedDesigner objectAtIndex:0] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg2 setImage:[UIImage imageNamed:@"plus_icon.png"] forState:UIControlStateNormal];
            [_designerImg3 setImage:[UIImage imageNamed:@"minuse_icon.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [_designerImg1 setImageWithURL:[[_selectedDesigner objectAtIndex:0] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg2 setImageWithURL:[[_selectedDesigner objectAtIndex:1] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg3 setImage:[UIImage imageNamed:@"plus_icon.png"] forState:UIControlStateNormal];
            [_designerImg4 setImage:[UIImage imageNamed:@"minuse_icon.png"] forState:UIControlStateNormal];
            break;
        case 3:
            [_designerImg1 setImageWithURL:[[_selectedDesigner objectAtIndex:0] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg2 setImageWithURL:[[_selectedDesigner objectAtIndex:1] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg3 setImageWithURL:[[_selectedDesigner objectAtIndex:2] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg4 setImage:[UIImage imageNamed:@"plus_icon.png"] forState:UIControlStateNormal];
            [_designerImg5 setImage:[UIImage imageNamed:@"minuse_icon.png"] forState:UIControlStateNormal];
            break;
        case 4:
            [_designerImg1 setImageWithURL:[[_selectedDesigner objectAtIndex:0] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg2 setImageWithURL:[[_selectedDesigner objectAtIndex:1] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg3 setImageWithURL:[[_selectedDesigner objectAtIndex:2] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg4 setImageWithURL:[[_selectedDesigner objectAtIndex:3] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg5 setImage:[UIImage imageNamed:@"plus_icon.png"] forState:UIControlStateNormal];
            [_designerImg6 setImage:[UIImage imageNamed:@"minuse_icon.png"] forState:UIControlStateNormal];
            break;
        case 5:
            [_designerImg1 setImageWithURL:[[_selectedDesigner objectAtIndex:0] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg2 setImageWithURL:[[_selectedDesigner objectAtIndex:1] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg3 setImageWithURL:[[_selectedDesigner objectAtIndex:2] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg4 setImageWithURL:[[_selectedDesigner objectAtIndex:3] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg5 setImageWithURL:[[_selectedDesigner objectAtIndex:4] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg6 setImage:[UIImage imageNamed:@"plus_icon.png"] forState:UIControlStateNormal];
            [_designerImg7 setImage:[UIImage imageNamed:@"minuse_icon.png"] forState:UIControlStateNormal];
            break;
        case 6:
            [_designerImg1 setImageWithURL:[[_selectedDesigner objectAtIndex:0] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg2 setImageWithURL:[[_selectedDesigner objectAtIndex:1] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg3 setImageWithURL:[[_selectedDesigner objectAtIndex:2] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg4 setImageWithURL:[[_selectedDesigner objectAtIndex:3] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg5 setImageWithURL:[[_selectedDesigner objectAtIndex:4] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg6 setImageWithURL:[[_selectedDesigner objectAtIndex:5] objectForKey:@"avatar"] forState:UIControlStateNormal placeholderImage:nil];
            [_designerImg7 setImage:[UIImage imageNamed:@"plus_icon.png"] forState:UIControlStateNormal];
            [_designerImg8 setImage:[UIImage imageNamed:@"minuse_icon.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)tableAction:(NSNotification *)notification
{
    NSIndexPath *index = (NSIndexPath *)[notification object];
    if (index == nil) {
        return;
    }
    @try {
        [_selectedDesigner addObject:[_designerData objectAtIndex:index.row]];
        [_designerData removeObjectAtIndex:index.row];
        _btnTag =[_selectedDesigner count];
        [self setupUI];
    }
    @catch (NSException *exception) {
        NSLog(@"{%@} push controller error",self.class);
    }
    @finally {
        
    }
}
@end
