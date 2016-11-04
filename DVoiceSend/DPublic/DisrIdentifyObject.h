//
//  DisrIdentifyObject.h
//  DVoiceSend
//
//  Created by DUCHENGWEN on 2016/10/25.
//  Copyright © 2016年 DCW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DISRDataHelper.h"
#import "DIATConfig.h"
#import "iflyMSC/iflyMSC.h"
#import "Definition.h"
#import "DISRDataHelper.h"

@protocol isrIdentifyDelegate <NSObject>

- (void) onResultsStringisrIdentifyDelegate:(NSString*) results isLast:(BOOL)isLast;//识别后的回调
- (void) onVolumeChangedImgisrIdentifyDelegate: (UIImage*)Img;//返回图片
- (void) onErrorStringisrIdentifyDelegate:(IFlySpeechError *)error;

@end


@interface DisrIdentifyObject : NSObject<IFlySpeechRecognizerDelegate,IFlyRecognizerViewDelegate>

@property (nonatomic, strong) NSString *pcmFilePath;//音频文件路径
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic, strong) IFlyDataUploader *uploader;//数据上传对象

@property(nonatomic)BOOL isrIdentifyImg;

@property (nonatomic, weak) id <isrIdentifyDelegate> delegate;

+ (DisrIdentifyObject*) sharedInstance;

/**
 设置识别参数
 ****/
-(void)initRecognizer;

/**
 启动听写
 *****/
- (void)startBtnHandler;

/**
 取消
 ****/
-(void)detectionStart;
/**
 完成
 ****/
-(void)stopListening;

@end
