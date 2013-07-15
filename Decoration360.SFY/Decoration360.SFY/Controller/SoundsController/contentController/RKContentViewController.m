//
//  RKContentViewController.m
//  Decoration360.SFY
//
//  Created by Evan on 13-7-1.
//  Copyright (c) 2013年 Evan. All rights reserved.
//

#import "RKContentViewController.h"
#import "RKContentTableViewCell.h"
#import "RKPhotoTalkingViewController.h"
#import "RKLoginViewController.h"
#import "Common.h"
#import "UIImageView+WebCache.h"

@interface RKContentViewController ()

@end

@implementation RKContentViewController

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
//    self.picImgView.image =_picImage;
    [_commitTextField setHidden:YES];
    [_sendBtn setHidden:YES];
    
    [_recordView setHidden:YES];
    [self audio];
    [_commitVoiceBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [_commitVoiceBtn addTarget:self action:@selector(btnUp:) forControlEvents:UIControlEventTouchUpInside];
    [_commitVoiceBtn addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragExit];
    
}



-(void)viewWillAppear:(BOOL)animated {
    [_tableView setHidden:YES];
    [Common cancelAllRequestOfAllQueue];
    [super viewWillAppear:animated];
	keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    [self requestDataQuery];
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
    [_picImgView release];
    [_commitVoiceBtn release];
    [_commitTextField release];
    [_sendBtn release];
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPicImgView:nil];
    [self setCommitVoiceBtn:nil];
    [self setCommitTextField:nil];
    [self setSendBtn:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}

#pragma mark - buttonAction


- (IBAction)changeBtnPressed:(UIButton *)sender {
    if (sender.tag ==0) {
        sender.tag =1;
        _sendBtn.tag =1;
        [_sendBtn setHidden:NO];
        [_commitTextField setHidden:NO];
        [_commitVoiceBtn setHidden:YES];
    }else {
        sender.tag =0;
        _sendBtn.tag =0;
        [_sendBtn setHidden:YES];
        [_commitTextField setHidden:YES];
        [_commitVoiceBtn setHidden:NO];
    }
}

- (IBAction)sendBtnPressed:(UIButton *)sender {
    if ([Common isLogined]) {
        RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
        [manager answerTheme:_commitTextField.text :[_mp3File stringByAppendingFormat:@".aac"] :_tid];
        _commitTextField.text =@"";
    }else {
        UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"请先登陆！" message:@"先登录才能发布主题" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] autorelease];
        alert.delegate =self;
        [alert show];
    }
}

- (IBAction)backBtnPressed:(id)sender {
    RKPhotoTalkingViewController *ptCtr =[[RKPhotoTalkingViewController alloc]init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"POPCONTROLLER" object:ptCtr];
    [ptCtr release];
}

- (IBAction)btnDown:(id)sender
{
    
    if ([Common isLogined]) {
        [_recordView setHidden:NO];
        //创建录音文件，准备录音
        if ([recorder prepareToRecord]) {
            //开始
            [recorder record];
        }
        //设置定时检测
        timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    }else {
        UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"请先登陆！" message:@"先登录才能发布主题" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] autorelease];
        alert.delegate =self;
        [alert show];
    }
}
- (IBAction)btnUp:(id)sender
{
    [_recordView setHidden:YES];
    double cTime = recorder.currentTime;
    if (cTime > 2) {//如果录制时间<2 不发送
        NSLog(@"发出去");
        [self performSelector:@selector(netanswer) withObject:self afterDelay:1.0f];
        //        [self audio_PCMtoMP3];
    }else {
        //删除记录的文件
        [recorder deleteRecording];
        //删除存储的
    }
    [recorder stop];
    [timer invalidate];
}
- (IBAction)btnDragUp:(id)sender
{
    [_recordView setHidden:YES];
    //删除录制文件
    [recorder deleteRecording];
    [recorder stop];
    [timer invalidate];
    
    NSLog(@"取消发送");
}

- (void)netanswer {
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    [manager answerTheme:_commitTextField.text :[_mp3File stringByAppendingFormat:@".aac"] :_tid];
}

#pragma mark - audio operation
- (void)audio
{
    //录音设置
    NSMutableDictionary *recordSetting = [[[NSMutableDictionary alloc]init] autorelease];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.mp3File =[Common getTime];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.aac", strUrl, _mp3File]];
    urlPlay = url;
    
    NSError *error;
    //初始化
    recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
}

- (void)detectionVoice
{
    [recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    //    NSLog(@"%lf",lowPassResults);
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.06) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
    }else if (0.06<lowPassResults<=0.13) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_02.png"]];
    }else if (0.13<lowPassResults<=0.20) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_03.png"]];
    }else if (0.20<lowPassResults<=0.27) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_04.png"]];
    }else if (0.27<lowPassResults<=0.34) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_05.png"]];
    }else if (0.34<lowPassResults<=0.41) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_06.png"]];
    }else if (0.41<lowPassResults<=0.48) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_07.png"]];
    }else if (0.48<lowPassResults<=0.55) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_08.png"]];
    }else if (0.55<lowPassResults<=0.62) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_09.png"]];
    }else if (0.62<lowPassResults<=0.69) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_10.png"]];
    }else if (0.69<lowPassResults<=0.76) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_11.png"]];
    }else if (0.76<lowPassResults<=0.83) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_12.png"]];
    }else if (0.83<lowPassResults<=0.9) {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_13.png"]];
    }else {
        [self.recordView setImage:[UIImage imageNamed:@"record_animate_14.png"]];
    }
}

- (void) updateImage
{
    [self.recordView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
}


#pragma mark - networkRequest
- (void)requestDataQuery {
    RKNetworkRequestManager *manager =[RKNetworkRequestManager sharedManager];
    manager.contentDelegate =self;
    [manager getContentInfo:_tid :@"0" :@"10"];
}

-(void)contentInfoData:(NSDictionary *)dict {
    self.dictData =[dict objectForKey:@"topic"];
    self.commentArray =[dict objectForKey:@"comments"];
    [_tableView setHidden:NO];
    [_tableView reloadData];
}

#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_dictData objectForKey:@"num"] intValue]+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    RKContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil) {
        NSArray *xib=[[NSBundle mainBundle] loadNibNamed:@"RKContentTableViewCell" owner:self options:nil];
        cell =(RKContentTableViewCell *)[xib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setHighlighted:NO];
    if (indexPath.row ==0) {
        [cell.contentText setHidden:YES];
        [cell.iconImageView setHidden:YES];
        
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 281.1f)];
        imageView.image =_picImage;
        
        UIButton *playBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playBtn setFrame:CGRectMake(124.0f, 266.1f, 72.0f, 30.0f)];
        [playBtn addTarget:self action:@selector(themePlayBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        [playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [cell addSubview:imageView];
        [cell addSubview:playBtn];
        [cell.playBtn setHidden:YES];
        return cell;
    }else if ( indexPath.row == [[_dictData objectForKey:@"num"] intValue]+1){
        [cell.contentText setHidden:YES];
        [cell.playBtn setHidden:YES];
        [cell.iconImageView setHidden:YES];
        
        UIButton *playBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playBtn setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)];
        [playBtn setTitle:@"加载更多" forState:UIControlStateNormal];
        [cell addSubview:playBtn];
        return cell;
    }else {
        cell.contentText.editable =NO;
        NSDictionary *commentDict =[_commentArray objectAtIndex:indexPath.row-1];
        NSString *content =[commentDict objectForKey:@"content"];
        if (content.length !=0) {
            [cell.playBtn setHidden:YES];
            cell.contentText.text =[NSString stringWithFormat:@"%@: %@", [commentDict objectForKey:@"uid"], [commentDict objectForKey:@"content"]];
            [cell.iconImageView setImageWithURL:[commentDict objectForKey:@"pic_url"] placeholderImage:[UIImage imageNamed:@"icon_default.png"]];
        }else {
            cell.contentText.text =[NSString stringWithFormat:@"%@: ", [commentDict objectForKey:@"uid"]];
            [cell.iconImageView setImageWithURL:[commentDict objectForKey:@"pic_url"] placeholderImage:[UIImage imageNamed:@"icon_default.png"]];
        }
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        return 350.0f;
    }else if ( indexPath.row == [[_dictData objectForKey:@"num"] intValue]+1){
        return 32.0f;
    }else {
        return 72.0f;
    }
}


#pragma mark -cellAction
- (void)themePlayBtnPressed {
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex ==1) {
        RKLoginViewController *lvCtr =[[RKLoginViewController alloc]init];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTROLLER" object:lvCtr];
        [lvCtr release];
    }
}

@end
