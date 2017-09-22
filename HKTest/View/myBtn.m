//
//  myBtn.m
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import "myBtn.h"

@implementation myBtn

#define W frame.size.width
#define H frame.size.height
-(instancetype)initWithFrame:(CGRect)frame img:(UIImage *)img title:(NSString *)title touchEvent:(T)event andbtnType:(BTNTYPE)type{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(W*0.1, H*0.1, W*0.4, H*0.8)];
        imgv.image = img;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(W*0.5, H*0.1, W*0.5, H*0.8)];
        lab.text  = title;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:14];
        _lab = lab;
        _imgv = imgv;
        if (type == BTNTYPELR) {
            [self addSubview:imgv];
            [self addSubview:lab];
            
        }
        if (type == BTNTYPEUD) {
            imgv.frame = CGRectMake(W*0.25, H*0.1,W*0.5,H*0.5 );
            lab.frame = CGRectMake(0, H*0.6, W, H*0.4);
            [self addSubview:imgv];
            [self addSubview:lab];
        }
        if (type == BTNTYPEIMG) {
            imgv.frame = CGRectMake(W*0.1, H*0.1,W*0.8,H*0.8 );
            [self addSubview:imgv];
        }
        if (type == BTNTYPETEXT) {
            lab.frame = CGRectMake(W*0.1, H*0.1,W*0.8,H*0.8 );
            [self addSubview:lab];
        }
        if (type == BTNTYPEOTHER) {
            imgv.frame = CGRectMake(W*0.1, H*0.3,W*0.2,H*0.4 );
            lab.frame = CGRectMake(W*0.4, H*0.2, W*0.6, H*0.6);
            lab.textAlignment = NSTextAlignmentLeft;
            [self addSubview:imgv];
            [self addSubview:lab];
        }
        
    }
    _touchEvent = event;
    return self;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchEvent) {
        _touchEvent(self);
    }
}

@end
