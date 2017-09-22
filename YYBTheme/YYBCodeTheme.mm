//
//  YYBCodeTheme.m
//  testOfThem
//
//  Created by MyMac on 16/9/20.
//  Copyright © 2016年 Bobby. All rights reserved.
//

#import "YYBCodeTheme.h"
#import "YYBThemeManager.h"
#import "NSObject+YYBTheme.h"
#import "NSString+YYBConvert.h"

@interface YYBCodeTheme ()

@property (nonatomic, copy, readonly) YYBBlockTypeTagKeyPathColor addKeyPathColor;
@property (nonatomic, copy, readonly) YYBBlockTypeTagKeyPathImage addKeyPathImage;
@end

@implementation YYBCodeTheme

#define YYBBlockTypeTagColor(blockName, keyPath) \
- (YYBBlockTypeTagColor)blockName { \
__weak typeof(self) weakSelf = self; \
NSString *keyPathStr = keyPath == nil ? NSStringFromSelector(_cmd) : keyPath; \
return ^(NSString *tag, UIColor *color) { \
return weakSelf.addKeyPathColor(tag, keyPathStr, color); \
}; \
}

YYBBlockTypeTagColor(backgroundColor, nil)
YYBBlockTypeTagColor(textColor, nil)
YYBBlockTypeTagColor(tintColor, nil)
YYBBlockTypeTagColor(fillColor, nil)
YYBBlockTypeTagColor(strokeColor, nil)
YYBBlockTypeTagColor(borderColor, nil)
YYBBlockTypeTagColor(shadowColor, nil)
YYBBlockTypeTagColor(onTintColor, nil)
YYBBlockTypeTagColor(thumbTintColor, nil)
YYBBlockTypeTagColor(separatorColor, nil)
YYBBlockTypeTagColor(barTintColor, nil)
YYBBlockTypeTagColor(placeholderColor, @"_placeholderLabel.textColor")
YYBBlockTypeTagColor(trackTintColor, nil)
YYBBlockTypeTagColor(progressTintColor, nil)
YYBBlockTypeTagColor(highlightedTextColor, nil)
YYBBlockTypeTagColor(pageIndicatorTintColor, nil)
YYBBlockTypeTagColor(currentPageIndicatorTintColor, nil)

- (YYBBlockTypeTagKeyPathColor)addKeyPathColor {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, NSString *keyPath, UIColor *color) {
        // 给配置字典赋值
        [[YYBThemeManager sharedManager] addTag:tag];
        NSMutableDictionary *info = [weakSelf.info1 objectForKey:keyPath];
        if (!info) info = [[NSMutableDictionary alloc] init];
        [info setObject:color forKey:tag];
        [weakSelf.info1 setObject:info forKey:keyPath];
        if ([[[YYBThemeManager sharedManager] currentTag] isEqualToString:tag]) { // 如果主题相同，则改变
            if ([weakSelf.view YYB_isCGColorWithKeyPath:keyPath]) {
                [weakSelf.view setValue:(id)[color CGColor] forKey:keyPath];
            } else {
                [weakSelf.view setValue:color forKey:keyPath];
            }
        }
        return weakSelf;
    };
}

- (YYBBlockTypeTagColorState)titleColorWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, UIColor *color, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"设置titleColorWithState的对象应该是UIButton");
        [[YYBThemeManager sharedManager] addTag:tag];
        NSMutableDictionary *info = weakSelf.info2[tag];
        if (!info) {
            info = [[NSMutableDictionary alloc] init];
            [weakSelf.info2 setObject:info forKey:tag];
        }
        [info setObject:color forKey:@(state)];
        if ([[[YYBThemeManager sharedManager] currentTag] isEqualToString:tag]) { // 如果主题相同，则改变
            [(UIButton *)weakSelf.view setTitleColor:color forState:state];
        }
        
        return weakSelf;
    };
}

- (YYBBlockTypeTagColorState)titleShadowColorWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, UIColor *color, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"设置titleShadowColorWithState的对象应该是UIButton");
        NSMutableDictionary *info = weakSelf.info3[tag];
        if (!info) {
            info = [[NSMutableDictionary alloc] init];
            [weakSelf.info3 setObject:info forKey:tag];
        }
        [info setObject:color forKey:@(state)];
        if ([[[YYBThemeManager sharedManager] currentTag] isEqualToString:tag]) { // 如果主题相同，则改变
            [(UIButton *)weakSelf.view setTitleShadowColor:color forState:state];
        }
        return weakSelf;
    };
}

- (YYBBlockTypeTagImageState)imageWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, id image, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"设置imageWithState的对象应该是UIButton");
        NSMutableDictionary *info = weakSelf.info4[tag];
        if (!info) {
            info = [[NSMutableDictionary alloc] init];
            [weakSelf.info4 setObject:info forKey:tag];
        }
        [info setObject:image forKey:@(state)];
        if ([[[YYBThemeManager sharedManager] currentTag] isEqualToString:tag]) { // 如果主题相同，则改变
            UIImage *i = [image isKindOfClass:[UIImage class]] ? image : [image YYB_toImage];
            [(UIButton *)weakSelf.view setImage:i forState:state];
        }
        return weakSelf;
    };
}

- (YYBBlockTypeTagImageState)backgroundImageWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, id image, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"设置imageWithState的对象应该是UIButton");
        NSMutableDictionary *info = weakSelf.info5[tag];
        if (!info) {
            info = [[NSMutableDictionary alloc] init];
            [weakSelf.info5 setObject:info forKey:tag];
        }
        [info setObject:image forKey:@(state)];
        if ([[[YYBThemeManager sharedManager] currentTag] isEqualToString:tag]) { // 如果主题相同，则改变
            UIImage *i = [image isKindOfClass:[UIImage class]] ? image : [image YYB_toImage];
            [(UIButton *)weakSelf.view setBackgroundImage:i forState:state];
        }
        return weakSelf;
    };
}

- (YYBBlockTypeTagDictionaryState)titleTextAttributesWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, NSDictionary *dict, UIControlState state) {
        [[YYBThemeManager sharedManager] addTag:tag];
        NSMutableDictionary *info = [weakSelf.info7 objectForKey:tag];
        if (!info) {
            info = [[NSMutableDictionary alloc] init];
            [weakSelf.info7 setObject:info forKey:tag];
        }
        [info setObject:dict forKey:@(state)];
        if ([[[YYBThemeManager sharedManager] currentTag] isEqualToString:tag]) { // 如果主题相同，则改变
            [(UITabBarItem *)weakSelf.view setTitleTextAttributes:dict forState:state];
        }
        return weakSelf;
    };
}

#define YYBBlockTypeTagImage(blockName, keyPath) \
- (YYBBlockTypeTagImage)blockName { \
__weak typeof(self) weakSelf = self; \
NSString *keyPathStr = keyPath == nil ? NSStringFromSelector(_cmd) : keyPath; \
return ^(NSString *tag, id image) { \
return weakSelf.addKeyPathImage(tag, keyPathStr, image); \
}; \
}

YYBBlockTypeTagImage(image, nil)
YYBBlockTypeTagImage(trackImage, nil)
YYBBlockTypeTagImage(progressImage, nil)
YYBBlockTypeTagImage(shadowImage, nil)
YYBBlockTypeTagImage(selectedImage, nil)
YYBBlockTypeTagImage(backgroundImage, nil)
YYBBlockTypeTagImage(backIndicatorImage, nil)
YYBBlockTypeTagImage(backIndicatorTransitionMaskImage, nil)
YYBBlockTypeTagImage(selectionIndicatorImage, nil)
YYBBlockTypeTagImage(scopeBarBackgroundImage, nil)

- (YYBBlockTypeTagKeyPathImage)addKeyPathImage {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, NSString *keyPath, id image) {
        [[YYBThemeManager sharedManager] addTag:tag];
        NSMutableDictionary *info = [weakSelf.info6 objectForKey:keyPath];
        if (!info) {
            info = [[NSMutableDictionary alloc] init];
            [weakSelf.info6 setObject:info forKey:keyPath];
        }
        [info setObject:image forKey:tag];
        if ([[[YYBThemeManager sharedManager] currentTag] isEqualToString:tag]) { // 如果主题相同，则改变
            UIImage *i = [image isKindOfClass:[UIImage class]] ? image : [image YYB_toImage];
            [weakSelf.view setValue:i forKey:keyPath];
        }
        return weakSelf;
    };
}

- (YYBBlockTypeTagStr)text {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, NSString *str) {
        [[YYBThemeManager sharedManager] addTag:tag];
        [weakSelf.info8 setValue:str forKey:tag];
        [weakSelf manageInfo8];
        return weakSelf;
    };
}

- (YYBBlockTypeTagStrState)titleWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, NSString *str, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"设置titleWithState的对象应该是UIButton");
        [[YYBThemeManager sharedManager] addTag:tag];
        NSMutableDictionary *info = [weakSelf.info9 objectForKey:tag];
        if (!info) {
            info = [[NSMutableDictionary alloc] init];
            [weakSelf.info9 setObject:info forKey:tag];
        }
        [info setObject:str forKey:@(state)];
        [self manageInfo9];
        
        return weakSelf;
    };
}

#pragma mark - 根据字典配置信息刷新视图

- (void)manageInfo1 {
    for (NSString *keyPath in self.info1) {
        NSMutableDictionary *info = [self.info1 objectForKey:keyPath];
        UIColor *color = [info objectForKey:[[YYBThemeManager sharedManager] currentTag]];
        if (color) {
            if ([self.view YYB_isCGColorWithKeyPath:keyPath]) {
                [self.view setValue:(id)[color CGColor] forKey:keyPath];
            } else {
                [self.view setValue:color forKey:keyPath];
            }
        }
    }
}

- (void)manageInfo2 {
    NSDictionary *info = [self.info2 objectForKey:[[YYBThemeManager sharedManager] currentTag]];
    if (info) {
        for (NSNumber *key in info) {
            UIControlState state = [key unsignedIntegerValue];
            [(UIButton *)self.view setTitleColor:info[key] forState:state];
        }
    }
}

- (void)manageInfo3 {
    NSDictionary *info = [self.info3 objectForKey:[[YYBThemeManager sharedManager] currentTag]];
    if (info) {
        for (NSNumber *key in info) {
            UIControlState state = [key unsignedIntegerValue];
            [(UIButton *)self.view setTitleShadowColor:info[key] forState:state];
        }
    }
}

- (void)manageInfo4 {
    NSDictionary *info = [self.info4 objectForKey:[[YYBThemeManager sharedManager] currentTag]];
    if (info) {
        for (NSNumber *key in info) {
            UIControlState state = [key unsignedIntegerValue];
            [(UIButton *)self.view setImage:info[key] forState:state];
        }
    }
}

- (void)manageInfo5 {
    NSDictionary *info = [self.info5 objectForKey:[[YYBThemeManager sharedManager] currentTag]];
    if (info) {
        for (NSNumber *key in info) {
            UIControlState state = [key unsignedIntegerValue];
            [(UIButton *)self.view setBackgroundImage:info[key] forState:state];
        }
    }
}

- (void)manageInfo6 {
    NSDictionary *info = self.info6;
    for (NSString *key in info) {
        NSDictionary *dict = [info objectForKey:key];
        id value = [dict objectForKey:[[YYBThemeManager sharedManager] currentTag]];
        if (value) {
            UIImage *image = [value isKindOfClass:[UIImage class]] ? value : [value YYB_toImage];
            [self.view setValue:image forKey:key];
        }
    }
}

- (void)manageInfo7 {
    NSDictionary *info = self.info7;
    NSDictionary *dict = [info objectForKey:[[YYBThemeManager sharedManager] currentTag]];
    if (dict) {
        for (NSNumber *stateKey in dict.allKeys) {
            UIControlState state = [stateKey unsignedIntegerValue];
            [(UITabBarItem *)self.view setTitleTextAttributes:dict[stateKey] forState:state];
        }
    }
}

- (void)manageInfo8 {
    NSString *text = [self.info8 objectForKey:[[YYBThemeManager sharedManager] currentTag]];
    if (text) {
        [self.view setValue:text forKey:@"text"];
    }
}

- (void)manageInfo9 {
    NSDictionary *info = self.info9;
    NSDictionary *dict = [info objectForKey:[[YYBThemeManager sharedManager] currentTag]];
    if (dict) {
        for (NSNumber *stateKey in dict.allKeys) {
            UIControlState state = [stateKey unsignedIntegerValue];
            [(UIButton *)self.view setTitle:dict[stateKey] forState:state];
        }
    }
}

@end
