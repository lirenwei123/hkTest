//
//  YYBThemeExtern.h
//  testOfThem
//
//  Created by MyMac on 16/9/20.
//  Copyright © 2016年 Bobby. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const YYBThemeChangingNotificaiton;
extern NSString * const YYBThemeCurrentTag;

// 懒加载宏定义
#define LazyLoad_Common(ClassName, varName) \
- (ClassName *)varName { \
if (_##varName == nil) { \
_##varName = [[ClassName alloc] init]; \
} \
return _##varName; \
}
