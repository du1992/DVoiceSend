//
//  DVoiceTouchView.h
//  DVoiceSend
//
//  Created by DUCHENGWEN on 2016/10/26.
//  Copyright © 2016年 DCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface DVoiceTouchView : UIView

@property (nonatomic, copy) void (^touchBegan)  ();
@property (nonatomic, copy) void (^upglide) ();
@property (nonatomic, copy) void (^down) ();
@property (nonatomic, copy) void (^touchEnd) ();
@property (nonatomic, strong) UIButton *voiceButton;

@property (nonatomic) int areaY;//设置识别高度
@property (nonatomic) int clickTime;//设置长按时间

@end
