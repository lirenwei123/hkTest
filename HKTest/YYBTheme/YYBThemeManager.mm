//
//  YYBThemeManager.m
//  testOfThem
//
//  Created by MyMac on 16/9/20.
//  Copyright © 2016年 Bobby. All rights reserved.
//

#import "YYBThemeManager.h"
#import "YYBThemeExtern.h"


@implementation YYBThemeManager

- (instancetype)init {
    if (self = [super init]) {
        NSString *currentTag = [[NSUserDefaults standardUserDefaults] objectForKey:YYBThemeCurrentTag];
        if (currentTag) {
            self.currentTag = currentTag;
        }
    }
    return self;
}

+ (instancetype)sharedManager {
    static YYBThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YYBThemeManager alloc] init];
    });
    return manager;
}

- (void)defaultTheme:(NSString *)tag {
    if (![self currentTag] ) {
        [self setCurrentTag:tag];
    }
}

- (void)startTheme:(NSString *)tag {
    NSAssert([self.allTags containsObject:tag], @"所启用的主题不存在 - 请检查是否添加了主题: %@", tag);
    if ([self.currentTag isEqualToString:tag]) return;
    self.currentTag = tag;
    [[NSNotificationCenter defaultCenter] postNotificationName:YYBThemeChangingNotificaiton object:nil];
}

- (void)addTag:(NSString *)tag {
    NSAssert(tag.length > 0, @"主题不可为空");
    [self.allTags addObject:tag];
}

- (void)setCurrentTag:(NSString *)currentTag {
    _currentTag = currentTag;
    if ([self.allTags containsObject:currentTag] == NO) {
        [self.allTags addObject:currentTag];
    }
    [[NSUserDefaults standardUserDefaults] setObject:currentTag forKey:YYBThemeCurrentTag];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)addTheme:(NSString *)themeTag jsonData:(NSData *)jsonData {
    if (themeTag == nil || jsonData == nil || jsonData.length <= 0) return;
    NSError *jsonError = nil;
    NSDictionary *themeDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    NSAssert(!jsonError, @"添加的主题json配置数据解析错误 - 错误描述");
    NSAssert(themeDict, @"添加的主题json配置数据解析为空 - 请检查");
    [self.allTags addObject:themeTag];
    [self.info setObject:themeDict forKey:themeTag];
}

- (NSString *)getColorStrValue:(NSString *)key {
    return [self getStrValueWithStyle:@"UIColor" key:key];
}

- (NSString *)getImageStrValue:(NSString *)key {
    return [self getStrValueWithStyle:@"UIImage" key:key];
}

- (NSString *)getTextStrValue:(NSString *)key {
    return [self getStrValueWithStyle:@"NSString" key:key];
}

- (NSString *)getOtherStrValue:(NSString *)key {
    return [self getStrValueWithStyle:@"other" key:key];
}

- (NSString *)getStrValueWithStyle:(NSString *)style key:(NSString *)key {
    NSDictionary *themeDict = self.info[[[YYBThemeManager sharedManager] currentTag]];
    NSAssert(themeDict, @"未取得相关主题: %@ key: %@", [[YYBThemeManager sharedManager] currentTag], key);
    NSDictionary *styleDict = [themeDict objectForKey:style];
    return [styleDict objectForKey:key];
}

LazyLoad_Common(NSMutableSet, allTags)
LazyLoad_Common(NSMutableDictionary, info)

@end

