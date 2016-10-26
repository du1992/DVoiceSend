//
//  DIATConfig.h
//  DVoiceSend
//
//  Created by DUCHENGWEN on 2016/10/26.
//  Copyright © 2016年 DCW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iflyMSC/IFlyMSC.h"
#import "Definition.h"
#import "DIATConfig.h"
#import "DISRDataHelper.h"

@interface DIATConfig : NSObject

+(DIATConfig *)sharedInstance;


+(NSString *)mandarin;
+(NSString *)cantonese;
+(NSString *)henanese;
+(NSString *)chinese;
+(NSString *)english;
+(NSString *)lowSampleRate;
+(NSString *)highSampleRate;
+(NSString *)isDot;
+(NSString *)noDot;


/**
 以下参数，需要通过
 iFlySpeechRecgonizer
 进行设置
 ****/
@property (nonatomic, strong) NSString *speechTimeout;
@property (nonatomic, strong) NSString *vadEos;
@property (nonatomic, strong) NSString *vadBos;

@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *accent;

@property (nonatomic, strong) NSString *dot;
@property (nonatomic, strong) NSString *sampleRate;


/**
 以下参数无需设置
 不必关
 ****/
@property (nonatomic, assign) BOOL haveView;
@property (nonatomic, strong) NSArray *accentIdentifer;
@property (nonatomic, strong) NSArray *accentNickName;



@end
