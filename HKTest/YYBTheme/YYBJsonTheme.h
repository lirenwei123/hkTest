//
//  YYBJsonTheme.h
//  testOfThem
//
//  Created by MyMac on 16/9/20.
//  Copyright © 2016年 Bobby. All rights reserved.
//

#import "YYBBaseTheme.h"

@class YYBJsonTheme;

typedef YYBJsonTheme * (^YYBBlockTypeIdentifier)(NSString *identifier);
typedef YYBJsonTheme * (^YYBBlockTypeIdentifierState)(NSString *identifier, UIControlState state);
typedef YYBJsonTheme * (^YYBBlockTypeKeyPathIdentifier)(NSString *keyPath, NSString *identifier);
typedef YYBJsonTheme * (^YYBBlockTypeDictionaryState)(NSDictionary *dict, UIControlState state);

@interface YYBJsonTheme : YYBBaseTheme

#pragma mark - JSON方式 :: Color
/** 设置backgroundColor -> 格式: .backgroundColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier backgroundColor;

/** 设置textColor -> 格式: .textColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier textColor;

/** 设置tintColor -> 格式: .tintColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier tintColor;

/** 设置fillColor -> 格式: .fillColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier fillColor;

/** 设置strokeColor -> 格式: .strokeColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier strokeColor;

/** 设置borderColor -> 格式: .borderColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier borderColor;

/** 设置shadowColor -> 格式: .shadowColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier shadowColor;

/** 设置onTintColor -> 格式: .onTintColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier onTintColor;

/** 设置thumbTintColor -> 格式: .thumbTintColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier thumbTintColor;

/** 设置separatorColor -> 格式: .separatorColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier separatorColor;

/** 设置barTintColor -> 格式: .barTintColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier barTintColor;

/** 设置placeholderColor -> 格式: .placeholderColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier placeholderColor;

/** 设置trackTintColor -> 格式: .trackTintColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier trackTintColor;

/** 设置progressTintColor -> 格式: .progressTintColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier progressTintColor;

/** 设置highlightedTextColor -> 格式: .highlightedTextColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier highlightedTextColor;

/** 设置pageIndicatorTintColor -> 格式: .pageIndicatorTintColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier pageIndicatorTintColor;

/** 设置currentPageIndicatorTintColor -> 格式: .currentPageIndicatorTintColor(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier currentPageIndicatorTintColor;
// -------------------------------------------------------------------------------------

/** 设置按钮标题颜色 -> 格式: .titleColorWithState(NSString *identifier, UIControlState state) */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifierState titleColorWithState;

/** 设置按钮标题阴颜色 -> 格式: .titleShadowColorWithState(NSString *identifier, UIControlState state) */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifierState titleShadowColorWithState;
// -------------------------------------------------------------------------------------

/** 设置文本 -> 格式: .text(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier text;
// -------------------------------------------------------------------------------------

/** 设置UIButton不同状态下的title -> 格式: .titleWithState(NSString *identifier, UIControlState state) */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifierState titleWithState;

#pragma mark - JSON方式 :: Image
/** 设置image -> 格式: .image(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier image;

/** 设置trackImage -> 格式: .trackImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier trackImage;

/** 设置trackImage -> 格式: .trackImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier progressImage;

/** 设置shadowImage -> 格式: .trackImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier shadowImage;

/** 设置shadowImage -> 格式: .selectedImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier selectedImage;

/** 设置shadowImage -> 格式: .backgroundImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier backgroundImage;

/** 设置backIndicatorImage -> 格式: .backIndicatorImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier backIndicatorImage;

/** 设置backIndicatorTransitionMaskImage -> 格式: .backIndicatorTransitionMaskImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier backIndicatorTransitionMaskImage;

/** 设置selectionIndicatorImage -> 格式: .selectionIndicatorImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier selectionIndicatorImage;

/** 设置scopeBarBackgroundImage -> 格式: .scopeBarBackgroundImage(@@"identifier") */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifier scopeBarBackgroundImage;
// -------------------------------------------------------------------------------------

/** 设置UIButton的image -> 格式: .imageWithState(@@"identifier", UIControlState) */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifierState imageWithState;

/** 设置UIButton的backgroundImageWithState -> 格式: .backgroundImageWithState(@@"identifier", UIControlState) */
@property (nonatomic, copy, readonly) YYBBlockTypeIdentifierState backgroundImageWithState;
// -------------------------------------------------------------------------------------

/** 设置UIButton的titleTextAttributesWithState -> 格式: .titleTextAttributesWithState(Dict, UIControlState) */
@property (nonatomic, copy, readonly) YYBBlockTypeDictionaryState titleTextAttributesWithState;
// -------------------------------------------------------------------------------------


@end
