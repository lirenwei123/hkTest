//
//  section01.h
//  HKTest
//
//  Created by QianLong on 2017/9/14.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZiChanView.h"

@interface section01 : UIView



-(instancetype)initWithFrame:(CGRect)frame Icons:(NSArray<UIImage *> *)icons titles:(NSArray<NSAttributedString *> *)titles andDatas:(NSArray<NSArray *> *)datas dispalyDataCount:(NSInteger)dispalyDataCount andUpDownBtnClick:(void(^)())myZJTouch;

-(void)reloadDatasWithdisPlayDataCount:(NSInteger)count;
@end
