//
//  ZiChanView.h
//  HKTest
//
//  Created by QianLong on 2017/9/19.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZiChanView : UIView



//
@property(nonatomic,strong) UIView  *seperateLine;

-(instancetype)initWithFrame:(CGRect)frame currencyImage:(UIImage *)img title:(NSAttributedString *)title andData:(NSArray*)dataArray displayDataCount:(int)count upDownBlock:(void(^)(UIButton *btn))upDownBlock;
@end
