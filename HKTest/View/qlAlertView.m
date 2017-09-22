//
//  qlAlertView.m
//  HKTest
//
//  Created by QianLong on 2017/9/18.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "qlAlertView.h"

@interface qlAlertView ()
//
@property(nonatomic,assign)btnBlcok mybtn1TouchClick;
@property(nonatomic,assign)btnBlcok mybtn2TouchClick;
@end

@implementation qlAlertView
-(instancetype)initWithView:(UIView *)view andDefultButtonBlock:(btnBlcok)DefultButtonBlock DefultButtontitle:(NSString *)DefultButtontitle andOtherButtonBlock:(btnBlcok)OtherButtonBlock OtherButtontitle:(NSString *)OtherButtontitle{
    if (self == [super init]) {
        self.frame = CGRectMake(0,0 , [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height);
        UIView *tool = [[UIView alloc]initWithFrame:self.bounds];
        tool.backgroundColor = [UIColor grayColor];
        tool.alpha = 0.9;
        [self addSubview:tool];
        view .center = self.center;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        //添加底部按钮，如 取消/删除/确定等  
        if (DefultButtonBlock) {
            _mybtn1TouchClick = DefultButtonBlock;
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
            btn1.backgroundColor = [UIColor whiteColor];
            [btn1 setTitle:DefultButtontitle forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn1];
            if (OtherButtonBlock) {
                _mybtn2TouchClick = OtherButtonBlock;
                UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
                btn2.backgroundColor = [UIColor whiteColor];
                [btn2 setTitle:OtherButtontitle forState:UIControlStateNormal];
                [btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn2];
              
                [btn1 setFrame:CGRectMake(view.bounds.size.width*0.6, view.bounds.size.height-35, 40, 20)];
                [btn2 setFrame:CGRectMake(view.bounds.size.width-60, view.bounds.size.height-35, 40, 20)];
                
            }else{
                [btn1 setFrame:CGRectMake(view.bounds.size.width-100, view.bounds.size.height-35, 40, 20)];
            }
        }
    }
    return self;
}


-(void)btn1:(UIButton *)sender{
    if (_mybtn1TouchClick) {
        _mybtn1TouchClick(self,sender);
    }
}

-(void)btn2:(UIButton *)sender{
    if (_mybtn2TouchClick) {
        _mybtn2TouchClick(self,sender);
    }
}

@end
