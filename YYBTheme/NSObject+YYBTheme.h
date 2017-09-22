//
//  NSObject+YYBTheme.h
//  testOfThem
//
//  Created by MyMac on 16/9/20.
//  Copyright © 2016年 Bobby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYBJsonTheme.h"
#import "YYBCodeTheme.h"


@interface NSObject (YYBTheme)

@property (nonatomic) YYBJsonTheme *jsonTheme;
@property (nonatomic) YYBCodeTheme *codeTheme;

- (BOOL)YYB_isCGColorWithKeyPath:(NSString *)keyPath;

@end
