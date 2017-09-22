//
//  mySDK.m
//  HKTest
//
//  Created by QianLong on 2017/9/6.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//
#define WHTIETHEME @"white"
#define BLACKTHEME @"black"

#import "mySDK.h"
#import "NSObject+YYBTheme.h"
#import "YYBThemeManager.h"


@implementation mySDK

-(instancetype)init{
    if (self ==[super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 加载主题
    [[YYBThemeManager sharedManager] addTheme:WHTIETHEME jsonData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"tag_white_json.json"]]];
    [[YYBThemeManager sharedManager] addTheme:BLACKTHEME jsonData:[NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"tag_black_json.json"]]];
    
    
    // 指明默认主题
    [[YYBThemeManager sharedManager] defaultTheme:WHTIETHEME];
    
}



@end
