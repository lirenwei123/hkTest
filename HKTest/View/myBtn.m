//
//  myBtn.m
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import "myBtn.h"

@interface myBtn ()
@property(nonatomic,strong)UIImage * disableIMG;
@property(nonatomic,strong)UIImage * ableIMG;
@end


@implementation myBtn

#define W frame.size.width
#define H frame.size.height
-(instancetype)initWithFrame:(CGRect)frame  img:(UIImage *)img title:(NSString *)title touchEvent:(T)event andbtnType:(BTNTYPE)type{
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
        }if (type == BTNTYPHQ) {
            imgv.frame = CGRectMake(W*0.25, H*0.2,W*0.5,H*0.4 );
            lab.frame = CGRectMake(0, H*0.6, W, H*0.4);
            [self addSubview:imgv];
            [self addSubview:lab];
            //增加向上向下按钮
            UIButton * ud = [UIButton buttonWithType:UIButtonTypeSystem];
            [ud setTitle:@"^" forState:UIControlStateNormal];
            [ud setFrame:CGRectMake(0, 0, W, H*0.2)];
            ud.tag = 100;
            [ud addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:ud];
            
        }
        
    }
    _touchEvent = event;
    return self;
}

-(void)btnClick:(UIButton *)sender{
    if (_btnState == BTNCONTOLDISABLE){
        return;
    }
    if (sender.tag == 100) {
        [sender setTitle:@"v" forState:UIControlStateNormal];
        sender.tag = 101;
       //用代理去处理事物
    }else{
        [sender setTitle:@"^" forState:UIControlStateNormal];
        sender.tag = 100;
         //用代理去处理事物
    }
}

-(instancetype)initWithFrame:(CGRect)frame normalImg:(UIImage *)img1 disableImg:(UIImage *)img2 title:(NSString *)title touchEvent:(T)event andbtnType:(BTNTYPE)type{
    _disableIMG = img2;
    _ableIMG = img1;
   return  [self initWithFrame:frame img:img1 title:title touchEvent:event andbtnType:type];
    
}

-(void)setBtnState:(BTNCONTOLSTATE)btnState{
    _btnState = btnState;
    if (_btnState == BTNCONTOLDISABLE) {
        self.userInteractionEnabled = NO;
        if (_disableIMG) {
            _imgv.image = _disableIMG;
        }
        _lab.textColor = [UIColor lightGrayColor];

    }else if (_btnState == BTNCONTOLNORMAL ){
        self.userInteractionEnabled = YES;
        if (_ableIMG) {
            _imgv.image = _ableIMG;
        }
        _lab.textColor = [UIColor blackColor];
    }
                                             
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchEvent) {
        _touchEvent(self);
    }
}

@end
