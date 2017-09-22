//
//  JRDDCountDetailView.m
//  HKTest
//
//  Created by QianLong on 2017/9/21.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "JRDDCountDetailView.h"


@implementation JRDDCountDetailView

+(instancetype)creatView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

-(void)setALLcount:(NSInteger )count1 ALLclick:(tapClick)allclick YCJcount:(NSInteger )count2 YCJclick:(tapClick)YCJclick DCJcount:(NSInteger )count3 DCJclick:(tapClick)DCJclick YCDcount:(NSInteger )count4 YCDclick:(tapClick)YCDclick{
    [_allDD setTitle:[NSString stringWithFormat:@"全部(%ld)",count1] forState:UIControlStateNormal];
    [_YCJ setTitle:[NSString stringWithFormat:@"已成交(%ld)",count2] forState:UIControlStateNormal];
    [_DCJ setTitle:[NSString stringWithFormat:@"待成交(%ld)",count3] forState:UIControlStateNormal];
    [_YCD setTitle:[NSString stringWithFormat:@"已撤单(%ld)",count4] forState:UIControlStateNormal];
    
    _click1 = allclick;
    _click2 = YCJclick;
    _click3 = DCJclick;
    _click4 = YCDclick;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
}

- (IBAction)allDingDan:(UIButton *)sender {
    [self removeFromSuperview];
    if (_click1) {
        _click1();
    }
}

- (IBAction)yiChengJiao:(UIButton *)sender {
    [self removeFromSuperview];
    if (_click2) {
        _click2();
    }
}

- (IBAction)daiChengJiao:(UIButton *)sender {
    [self removeFromSuperview];
    if (_click3) {
        _click3();
    }
}

- (IBAction)yiCheDan:(id)sender {
    [self removeFromSuperview];
    if (_click4) {
        _click4();
    }
}
@end


