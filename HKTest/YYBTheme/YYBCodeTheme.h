//
//  YYBCodeTheme.h
//  testOfThem
//
//  Created by MyMac on 16/9/20.
//  Copyright © 2016年 Bobby. All rights reserved.
//

#import "YYBBaseTheme.h"

@class YYBCodeTheme;

typedef YYBCodeTheme * (^YYBBlockTypeTagColor)(NSString *tag, UIColor *color);
typedef YYBCodeTheme * (^YYBBlockTypeTagColorState)(NSString *tag, UIColor *color, UIControlState state);
typedef YYBCodeTheme * (^YYBBlockTypeTagKeyPathColor)(NSString *tag, NSString *keyPath, UIColor *color);
typedef YYBCodeTheme * (^YYBBlockTypeTagDictionaryState)(NSString *tag, NSDictionary *dict, UIControlState state);
typedef YYBCodeTheme * (^YYBBlockTypeTagStr)(NSString *tag, NSString *str);
typedef YYBCodeTheme * (^YYBBlockTypeTagStrState)(NSString *tag, NSString *str, UIControlState state);

typedef YYBCodeTheme * (^YYBBlockTypeTagImage)(NSString *tag, id image); // image: 可以是UIImage | imageName | imagePath
typedef YYBCodeTheme * (^YYBBlockTypeTagImageState)(NSString *tag, id image, UIControlState state);
typedef YYBCodeTheme * (^YYBBlockTypeTagKeyPathImage)(NSString *tag, NSString *keyPath, id image);

typedef void (^YYBBlockType)(id item);
typedef YYBCodeTheme * (^YYBBlockTypeTagBlock)(NSString *tag, YYBBlockType block);
typedef YYBCodeTheme * (^YYBBlockTypeTagsBlock)(NSArray<NSString *> *tags, YYBBlockType block);
@interface YYBCodeTheme : YYBBaseTheme

#pragma mark - 自定义 :: Color
/** 设置backgroundColor -> 格式: .backgroundColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor backgroundColor;

/** 设置textColor -> 格式: .textColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor textColor;

/** 设置tintColor -> 格式: .tintColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor tintColor;

/** 设置fillColor -> 格式: .fillColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor fillColor;

/** 设置strokeColor -> 格式: .strokeColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor strokeColor;

/** 设置borderColor -> 格式: .borderColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor borderColor;

/** 设置shadowColor -> 格式: .shadowColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor shadowColor;

/** 设置onTintColor -> 格式: .onTintColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor onTintColor;

/** 设置thumbTintColor -> 格式: .thumbTintColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor thumbTintColor;

/** 设置separatorColor -> 格式: .separatorColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor separatorColor;

/** 设置barTintColor -> 格式: .barTintColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor barTintColor;

/** 设置placeholderColor -> 格式: .placeholderColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor placeholderColor;

/** 设置trackTintColor -> 格式: .trackTintColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor trackTintColor;

/** 设置progressTintColor -> 格式: .progressTintColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor progressTintColor;

/** 设置highlightedTextColor -> 格式: .highlightedTextColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor highlightedTextColor;

/** 设置pageIndicatorTintColor -> 格式: .pageIndicatorTintColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor pageIndicatorTintColor;

/** 设置currentPageIndicatorTintColor -> 格式: .currentPageIndicatorTintColor(主题标识, UIColor对象) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColor currentPageIndicatorTintColor;
// -------------------------------------------------------------------------------------

/** 设置按钮标题颜色 -> 格式: .titleColorWithState(主题标识, UIColor对象, UIControlState) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColorState titleColorWithState;

/** 设置按钮标题阴影色 -> 格式: .titleShadowColorWithState(主题标识, UIColor对象, UIControlState) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagColorState titleShadowColorWithState;

// -------------------------------------------------------------------------------------

#pragma mark - 自定义 :: Image
/** 设置image -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage image;

/** 设置trackImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage trackImage;

/** 设置progressImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage progressImage;

/** 设置shadowImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage shadowImage;

/** 设置selectedImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage selectedImage;

/** 设置backgroundImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage backgroundImage;

/** 设置backIndicatorImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage backIndicatorImage;

/** 设置backIndicatorTransitionMaskImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage backIndicatorTransitionMaskImage;

/** 设置selectionIndicatorImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage selectionIndicatorImage;

/** 设置scopeBarBackgroundImage -> 格式: .image(主题标识, image对象或名字) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImage scopeBarBackgroundImage;
// -------------------------------------------------------------------------------------

/** 设置UITabbarItem的titleTextAttributes -> 格式: .titleTextAttributesWithState(主题标识, Dict, UIControlState) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagDictionaryState titleTextAttributesWithState;
// -------------------------------------------------------------------------------------

/** 设置UIButton的图片 -> 格式: .imageWithState(NSString *tag, id image, UIControlState state) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImageState imageWithState;

/** 设置UIButton的背景色 -> 格式: .backgroundImageWithState(NSString *tag, id image, UIControlState state) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagImageState backgroundImageWithState;
// -------------------------------------------------------------------------------------

/** 设置文本 -> 格式: .text(NSString *tag, NSString *str) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagStr text;
// -------------------------------------------------------------------------------------

/** 设置不同状态下的title -> 格式: .titleWithState(NSString *tag, NSString *str, UIControlState state) */
@property (nonatomic, copy, readonly) YYBBlockTypeTagStrState titleWithState;
// -------------------------------------------------------------------------------------
@end
