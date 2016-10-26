//
//  DVoiceRecognitionViewController.m
//  DVoiceSend
//
//  Created by DUCHENGWEN on 2016/10/26.
//  Copyright © 2016年 DCW. All rights reserved.
//

#import "DVoiceRecognitionViewController.h"
#import "DisrIdentifyObject.h"
#import "DVoiceTouchView.h"


@interface DVoiceRecognitionViewController ()<isrIdentifyDelegate>


@property (weak, nonatomic) IBOutlet UILabel *voiceSendLabel;


@property (nonatomic, strong) UIImageView     *voiceIconImage;
@property (nonatomic, strong) UILabel         *voiceIocnTitleLable;
@property (nonatomic, strong) UIView          *voiceImageSuperView;
@property (nonatomic, assign) BOOL            voiceIsCancel;
@property (nonatomic, assign) BOOL            voiceRecognitionIsEnd;
@property (nonatomic, assign) BOOL            touchIsEnd;

@property (nonatomic, strong) UIImage         *normalImage;
@property (nonatomic, strong) UIImage         *selectedImage;
@property (nonatomic, copy)   NSString        *voiceString;

@property (nonatomic, strong) DVoiceTouchView *gesturesView;//继承长按手势视图

@end

@implementation DVoiceRecognitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor  whiteColor];
   
    [[DisrIdentifyObject sharedInstance] initRecognizer];
    [DisrIdentifyObject sharedInstance].delegate = self;
    
    __weak DVoiceRecognitionViewController *weakSelf = self;
    DVoiceTouchView *gesturesView = [[DVoiceTouchView alloc] initWithFrame:CGRectMake(screen_width/2-50, screen_height-35, 100, 30)];
    [self.view addSubview:gesturesView];
    self.gesturesView = gesturesView;
    self.gesturesView.areaY=-40;//设置滑动高度
    gesturesView.touchBegan = ^(){
        //开始长按
        [weakSelf touchDidBegan];
    };
    gesturesView.upglide = ^(){
        //在区域内
        [weakSelf touchupglide];
    };
    gesturesView.down = ^(){
        //不在区域内
        [weakSelf touchDown];
    };
    gesturesView.touchEnd = ^(){
        //松开
        [weakSelf touchDidEnd];
    };
    [gesturesView.voiceButton setTitle:@"按住说话" forState:UIControlStateNormal];
    [gesturesView.voiceButton setTitleColor:COLOR_RGB(105, 105, 105) forState:UIControlStateNormal];
    gesturesView.voiceButton.backgroundColor=[UIColor yellowColor];
    
}


-(void)touchDidBegan{
    if (!self.voiceIconImage) {
       
        UIView *voiceImageSuperView = [[UIView alloc] init];
        [self.view addSubview:voiceImageSuperView];
        voiceImageSuperView.backgroundColor = COLOR_RGBA(0, 0, 0, 0.6);
        self.voiceImageSuperView = voiceImageSuperView;
        __weak DVoiceRecognitionViewController *weakSelf = self;
        [voiceImageSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.view);
            make.size.mas_equalTo(CGSizeMake(140, 140));
        }];
        
        
        UIImageView *voiceIconImage = [[UIImageView alloc] init];
        self.voiceIconImage = voiceIconImage;
        [voiceImageSuperView addSubview:voiceIconImage];
        [voiceIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(voiceImageSuperView).insets(UIEdgeInsetsMake(20, 35, 0, 0));
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        
        UILabel *voiceIocnTitleLable = [[UILabel alloc] init];
        self.voiceIocnTitleLable = voiceIocnTitleLable;
        [voiceIconImage addSubview:voiceIocnTitleLable];
        voiceIocnTitleLable.textColor = [UIColor whiteColor];
        voiceIocnTitleLable.font = [UIFont systemFontOfSize:12];
        voiceIocnTitleLable.text = @"松开发送，上滑取消";
        [voiceIocnTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(voiceImageSuperView).offset(-15);
            make.centerX.equalTo(voiceImageSuperView);
        }];
    }
    self.voiceImageSuperView.hidden = NO;
    self.voiceIconImage.image = [UIImage imageNamed:@"语音 1"];
    self.voiceIocnTitleLable.text = @"松开发送，上滑取消";
    self.voiceIsCancel = NO;
    self.voiceString = [[NSString alloc] init];
    self.voiceRecognitionIsEnd = NO;
    self.touchIsEnd = NO;
    [_gesturesView.voiceButton setTitle:@"松开发送" forState:UIControlStateNormal];
    [[DisrIdentifyObject sharedInstance] detectionStart];
    [[DisrIdentifyObject sharedInstance] startBtnHandler];
}

-(void)setSelectedImage:(UIImage *)selectedImage{
    [_gesturesView.voiceButton setBackgroundImage:selectedImage forState:UIControlStateSelected];
}

-(void)setNormalImage:(UIImage *)normalImage{
    [_gesturesView.voiceButton setBackgroundImage:normalImage forState:UIControlStateNormal];
}

-(void)inputButtonAction:(UIButton *)button{
    
}

//语音回调
- (void) onResultsStringisrIdentifyDelegate:(NSString*) results isLast:(BOOL)isLast{
    self.voiceRecognitionIsEnd = isLast;
    if ([results length] > 0) {
        self.voiceString =  [self.voiceString stringByAppendingString:results];
        
    }
    
    if (isLast && self.touchIsEnd) {
        if (!self.voiceIsCancel && [self.voiceString length] > 0) {
            _voiceSendLabel.text=self.voiceString;
            
        }
    }
}

- (void) onVolumeChangedImgisrIdentifyDelegate: (UIImage*)Img{
    if (!self.voiceIsCancel) {
        self.voiceIconImage.image = Img;
    }
    
}
//错误信息
- (void) onErrorStringisrIdentifyDelegate:(IFlySpeechError *)error{
    _voiceSendLabel.text=self.voiceString;
}

-(void)touchupglide{
    self.voiceIsCancel = YES;
    self.voiceIocnTitleLable.text = @"松开手指，取消发送";
    self.voiceIconImage.image = [UIImage imageNamed:@"松开"];
}

-(void)touchDown{
    self.voiceIsCancel = NO;
    self.voiceIconImage.image = [UIImage imageNamed:@"语音 1"];
    self.voiceIocnTitleLable.text = @"松开发送，上滑取消";
}

-(void)touchDidEnd{
    self.voiceImageSuperView.hidden = YES;
    self.touchIsEnd = YES;
    [_gesturesView.voiceButton setTitle:@"按住说话" forState:UIControlStateNormal];
    
}









@end
