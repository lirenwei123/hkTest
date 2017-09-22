//
//  NSObject+YYBTheme.m
//  testOfThem
//
//  Created by MyMac on 16/9/20.
//  Copyright © 2016年 Bobby. All rights reserved.
//

#import "NSObject+YYBTheme.h"
#import <objc/runtime.h>
#import "YYBThemeExtern.h"
#import "YYBThemeManager.h"


@implementation NSObject (YYBTheme)

// dealloc -> YYB_dealloc
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"dealloc"];
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *YYBSelString = [@"YYB_" stringByAppendingString:selString];
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method YYBMethod = class_getInstanceMethod(self, NSSelectorFromString(YYBSelString));
            method_exchangeImplementations(originalMethod, YYBMethod);
        }];
    });
}

- (YYBJsonTheme *)jsonTheme {
    YYBJsonTheme *theme = objc_getAssociatedObject(self, _cmd);
    if (!theme) {
        NSAssert(![self isKindOfClass:[YYBJsonTheme class]], @"Class error: YYBTheme");
        theme = [[YYBJsonTheme alloc] init];
        self.jsonTheme = theme;
        self.jsonTheme.view = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YYB_themeChangingNotificaiton:) name:YYBThemeChangingNotificaiton object:nil];
    }
    
    return theme;
}

- (void)setJsonTheme:(YYBJsonTheme *)jsonTheme {
    if (jsonTheme) {
        objc_setAssociatedObject(self, @selector(jsonTheme), jsonTheme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (YYBCodeTheme *)codeTheme {
    YYBCodeTheme *theme = objc_getAssociatedObject(self, _cmd);
    if (!theme) {
        NSAssert(![self isKindOfClass:[YYBCodeTheme class]], @"Class error: YYBTheme");
        theme = [[YYBCodeTheme alloc] init];
        self.codeTheme = theme;
        self.codeTheme.view = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YYB_themeChangingNotificaiton:) name:YYBThemeChangingNotificaiton object:nil];
    }
    
    return theme;
}

- (void)setCodeTheme:(YYBCodeTheme *)codeTheme {
    if (codeTheme) {
        objc_setAssociatedObject(self, @selector(codeTheme), codeTheme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// 接到通知，触发
- (void)YYB_themeChangingNotificaiton:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self YYB_change];
    });
}

- (void)YYB_change {
    YYBCodeTheme *codeTheme = objc_getAssociatedObject(self, @selector(codeTheme));
    if (codeTheme) {
        [codeTheme manageInfos];
    }
    
    YYBJsonTheme *jsonTheme = objc_getAssociatedObject(self, @selector(jsonTheme));
    if (jsonTheme) {
        [jsonTheme manageInfos];
    }
}

- (BOOL)YYB_isCGColorWithKeyPath:(NSString *)keyPath {
    objc_property_t property = class_getProperty([self class], [keyPath UTF8String]);
    if (property != NULL) {
        return ([[NSString stringWithUTF8String:property_getAttributes(property)] isEqualToString:@"T^{CGColor=}"]) ? YES : NO;
    }
    return NO;
}

- (BOOL)isYYBTheme {
    return objc_getAssociatedObject(self, @selector(codeTheme)) || objc_getAssociatedObject(self, @selector(jsonTheme));
}

- (void)YYB_dealloc {
    if ([self isYYBTheme]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:YYBThemeChangingNotificaiton object:nil];
        objc_removeAssociatedObjects(self);
    }
    [self YYB_dealloc];
}



@end
