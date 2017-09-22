//
//  qlCellLeftView.m
//  HKTest
//
//  Created by QianLong on 2017/9/20.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "qlCellLeftView.h"

@implementation qlCellLeftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)leftView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

+(instancetype)leftNoImgView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}
@end
