//
//  section02.h
//  HKTest
//
//  Created by QianLong on 2017/9/14.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, MARKETTYPE) {
    MARKETTYPEHK = 1 << 0,
    MARKETTYPEUSA = 1 << 1,
    MARKETTYPEHGT = 1 << 2,
    MARKETTYPESGT = 1 << 3,
    MARKETTYPEOTHER = 1 << 4,
};

@class myBtn;
typedef void(^BTNClick)(myBtn *btn) ;

@interface section02 : UIView
//
@property(nonatomic,strong) BTNClick moreClick;


-(instancetype)initWithFrame:(CGRect)frame  andMarketType:(MARKETTYPE)marketType buttonClick:(BTNClick)btnClick;
@end
