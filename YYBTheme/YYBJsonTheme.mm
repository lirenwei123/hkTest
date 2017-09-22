//
//  YYBJsonTheme.m
//  testOfThem
//
//  Created by MyMac on 16/9/20.
//  Copyright © 2016年 Bobby. All rights reserved.
//

#import "YYBJsonTheme.h"
#import "YYBThemeManager.h"
#import "NSObject+YYBTheme.h"

@interface YYBJsonTheme ()

@property (nonatomic, copy, readonly) YYBBlockTypeKeyPathIdentifier addKeyPathColorIdentifier;
@property (nonatomic, copy, readonly) YYBBlockTypeKeyPathIdentifier addKeyPathImageIdentifier;
@end

@implementation YYBJsonTheme

#define YYBBlockTypeIdentifier(blockName, keyPath) \
- (YYBBlockTypeIdentifier)blockName { \
__weak typeof(self) weakSelf = self; \
NSString *keyPathStr = keyPath == nil ? NSStringFromSelector(_cmd) : keyPath; \
return ^(NSString *identifier) { \
return weakSelf.addKeyPathColorIdentifier(keyPathStr, identifier); \
}; \
}

YYBBlockTypeIdentifier(backgroundColor, nil)
YYBBlockTypeIdentifier(textColor, nil)
YYBBlockTypeIdentifier(tintColor, nil)
YYBBlockTypeIdentifier(fillColor, nil)
YYBBlockTypeIdentifier(strokeColor, nil)
YYBBlockTypeIdentifier(borderColor, nil)
YYBBlockTypeIdentifier(shadowColor, nil)
YYBBlockTypeIdentifier(onTintColor, nil)
YYBBlockTypeIdentifier(thumbTintColor, nil)
YYBBlockTypeIdentifier(separatorColor, nil)
YYBBlockTypeIdentifier(barTintColor, nil)
YYBBlockTypeIdentifier(placeholderColor, @"_placeholderLabel.textColor")
YYBBlockTypeIdentifier(trackTintColor, nil)
YYBBlockTypeIdentifier(progressTintColor, nil)
YYBBlockTypeIdentifier(highlightedTextColor, nil)
YYBBlockTypeIdentifier(pageIndicatorTintColor, nil)
YYBBlockTypeIdentifier(currentPageIndicatorTintColor, nil)

- (YYBBlockTypeKeyPathIdentifier)addKeyPathColorIdentifier {
    __weak typeof(self) weakSelf = self;
    // ie: keyPath: backgroundColor identifier: @"背景颜色二"
    return ^(NSString *keyPath, NSString *identifier) {
        // 给配置字典赋值
        [weakSelf.info1 setObject:identifier forKey:keyPath];
        if ([[YYBThemeManager sharedManager] currentTag]) {
            UIColor *color = [[[YYBThemeManager sharedManager] getColorStrValue:identifier] YYB_toColor];
            if ([weakSelf.view YYB_isCGColorWithKeyPath:keyPath]) {
                [weakSelf.view setValue:(id)[color CGColor] forKeyPath:keyPath];
            } else {
                [weakSelf.view setValue:color forKey:keyPath];
            }
        }
        return weakSelf;
    };
}

// typedef YYBJsonTheme * (^YYBBlockTypeIdentifierState)(NSString *identifier, UIControlState state);
// 传入：(@"背景颜色二", UIControlStateNormal)

- (YYBBlockTypeIdentifierState)titleColorWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *identifier, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"JsonTheme: 设置titleColorWithState的对象应该是UIButton");
        NSMutableDictionary *info = weakSelf.info2;
        [info setObject:identifier forKey:@(state)];
        UIColor *color = [[[YYBThemeManager sharedManager] getColorStrValue:identifier] YYB_toColor];
        [(UIButton *)weakSelf.view setTitleColor:color forState:state];
        return weakSelf;
    };
}

- (YYBBlockTypeIdentifierState)titleShadowColorWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *identifier, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"JsonTheme: 设置titleShadowColorWithState的对象应该是UIButton");
        NSMutableDictionary *info = weakSelf.info3;
        [info setObject:identifier forKey:@(state)];
        UIColor *color = [[[YYBThemeManager sharedManager] getColorStrValue:identifier] YYB_toColor];
        [(UIButton *)weakSelf.view setTitleShadowColor:color forState:state];
        return weakSelf;
    };
}

- (YYBBlockTypeIdentifierState)imageWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *identifier, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"JsonTheme: 设置imageWithState的对象应该是UIButton");
        NSMutableDictionary *info = weakSelf.info4;
        [info setObject:identifier forKey:@(state)];
        UIImage *image = [identifier YYB_toImage];
        [(UIButton *)weakSelf.view setImage:image forState:state];
        return weakSelf;
    };
}

- (YYBBlockTypeIdentifierState)backgroundImageWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *identifier, UIControlState state) {
        NSAssert([weakSelf.view isKindOfClass:[UIButton class]], @"JsonTheme: 设置backgroundImageWithState的对象应该是UIButton");
        NSMutableDictionary *info = weakSelf.info5;
        [info setObject:identifier forKey:@(state)];
        UIImage *image = [identifier YYB_toImage];
        [(UIButton *)weakSelf.view setBackgroundImage:image forState:state];
        return weakSelf;
    };
}

- (YYBBlockTypeDictionaryState)titleTextAttributesWithState {
    __weak typeof(self) weakSelf = self;
    // 传入值，如：@{NSForegroundColorAttributeName:@"背景颜色二"}
    return ^(NSDictionary *dict, UIControlState state) {
        // [weakSelf.info7 setDictionary:dict];
        // [weakSelf.info7 setValuesForKeysWithDictionary:dict];
        [weakSelf.info7 setObject:dict forKey:@(state)];
        
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        for (NSString *key in dict.allKeys) {
            if ([key isEqualToString:NSForegroundColorAttributeName]) { // 暂且判断此一层
                UIColor *color = [[[YYBThemeManager sharedManager] getColorStrValue:dict[key]] YYB_toColor];
                [info setObject:color forKey:key];
            }
        }
        [(UITabBarItem *)self.view setTitleTextAttributes:info forState:state];
        
        return weakSelf;
    };
}

#define YYBBlockTypeIdentifier_image(blockName, keyPath) \
- (YYBBlockTypeIdentifier)blockName { \
__weak typeof(self) weakSelf = self; \
NSString *keyPathStr = keyPath == nil ? NSStringFromSelector(_cmd) : keyPath; \
return ^(NSString *identifier) { \
return weakSelf.addKeyPathImageIdentifier(keyPathStr, identifier); \
}; \
}

YYBBlockTypeIdentifier_image(image, nil)
YYBBlockTypeIdentifier_image(trackImage, nil)
YYBBlockTypeIdentifier_image(progressImage, nil)
YYBBlockTypeIdentifier_image(shadowImage, nil)
YYBBlockTypeIdentifier_image(selectedImage, nil)
YYBBlockTypeIdentifier_image(backgroundImage, nil)
YYBBlockTypeIdentifier_image(backIndicatorImage, nil)
YYBBlockTypeIdentifier_image(backIndicatorTransitionMaskImage, nil)
YYBBlockTypeIdentifier_image(selectionIndicatorImage, nil)
YYBBlockTypeIdentifier_image(scopeBarBackgroundImage, nil)

- (YYBBlockTypeKeyPathIdentifier)addKeyPathImageIdentifier {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *keyPath, NSString *identifier) {
        [weakSelf.info6 setValue:identifier forKey:keyPath];
        UIImage *image = [[[YYBThemeManager sharedManager] getImageStrValue:identifier] YYB_toImage];
        if ([weakSelf.view isKindOfClass:[UITabBarItem class]]) {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        [weakSelf.view setValue:image forKey:keyPath];
        return weakSelf;
    };
}

- (YYBBlockTypeIdentifier)text {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *identifier) {
        [weakSelf.info8 setValue:identifier forKey:@"text"];
        [weakSelf manageInfo8];
        return weakSelf;
    };
}

- (YYBBlockTypeIdentifierState)titleWithState {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *identifier, UIControlState state) {
        [weakSelf.info9 setObject:identifier forKey:@(state)];
        [weakSelf manageInfo9];
        return weakSelf;
    };
}

#pragma mark - 根据字典配置信息刷新视图

- (void)manageInfo1 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSString *key in self.info1) {
            UIColor *color = [[[YYBThemeManager sharedManager] getColorStrValue:self.info1[key]] YYB_toColor];
            if ([self.view YYB_isCGColorWithKeyPath:key]) {
                [self.view setValue:(id)[color CGColor] forKey:key];
            } else {
                [self.view setValue:color forKey:key];
            }
        }
    }
}

- (void)manageInfo2 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSNumber *key in self.info2) {
            UIColor *color = [[[YYBThemeManager sharedManager] getColorStrValue:self.info2[key]] YYB_toColor];
            [(UIButton *)self.view setTitleColor:color forState:[key unsignedIntegerValue]];
        }
    }
}

- (void)manageInfo3 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSNumber *key in self.info3) {
            UIColor *color = [[[YYBThemeManager sharedManager] getColorStrValue:self.info3[key]] YYB_toColor];
            [(UIButton *)self.view setTitleShadowColor:color forState:[key unsignedIntegerValue]];
        }
    }
}

- (void)manageInfo4 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSNumber *key in self.info4) {
            UIImage *image = [[[YYBThemeManager sharedManager] getImageStrValue:self.info4[key]] YYB_toImage];
            [(UIButton *)self.view setImage:image forState:[key unsignedIntegerValue]];
        }
    }
}

- (void)manageInfo5 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSNumber *key in self.info5) {
            UIImage *image = [[[YYBThemeManager sharedManager] getImageStrValue:self.info5[key]] YYB_toImage];
            [(UIButton *)self.view setBackgroundImage:image forState:[key unsignedIntegerValue]];
        }
    }
}

- (void)manageInfo6 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSString *key in self.info6) {
            UIImage *image = [[[YYBThemeManager sharedManager] getImageStrValue:self.info6[key]] YYB_toImage];
            if ([self.view isKindOfClass:[UITabBarItem class]]) {
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }
            [self.view setValue:image forKey:key];
        }
    }
}

- (void)manageInfo7 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSNumber *key in self.info7.allKeys) {
            NSUInteger state = [key integerValue]; // UIControlStateSelected
            
            NSDictionary *dict = self.info7[key]; // @{NSForegroundColorAttributeName:@"背景颜色二"}
            NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
            for (NSString *strKey in dict.allKeys) {
                if ([strKey isEqualToString:NSForegroundColorAttributeName]) { // 暂且判断此一层
                    UIColor *color = [[[YYBThemeManager sharedManager] getColorStrValue:dict[strKey]] YYB_toColor];
                    [info setObject:color forKey:strKey];
                }
            }
            
            [(UITabBarItem *)self.view setTitleTextAttributes:info forState:state];
        }
    }
}

- (void)manageInfo8 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSString *key in self.info8) {
            [self.view setValue:[[YYBThemeManager sharedManager] getTextStrValue:self.info8[key]] forKey:key];
        }
    }
}

- (void)manageInfo9 {
    if ([[YYBThemeManager sharedManager] currentTag]) {
        for (NSNumber *key in self.info9) {
            NSString *identifier = [self.info9 objectForKey:key];
            [(UIButton *)self.view setTitle:[[YYBThemeManager sharedManager] getTextStrValue:identifier] forState:[key unsignedIntegerValue]];
        }
    }
}

@end
