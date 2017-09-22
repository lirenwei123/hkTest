//
//  JYSelectMedu.m
//  HKTest
//
//  Created by QianLong on 2017/9/20.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "JYSelectMedu.h"


#define sw self.frame.size.width
#define sh self.frame.size.height




@interface JYSelectMedu ()
//
@property(nonatomic,strong) btnTouch btnClick;
@end
@implementation JYSelectMedu

-(instancetype)initWithFrame:(CGRect)frame  btnClick:(btnTouch)btnClick{
    if (self == [super initWithFrame:frame]) {
        _btnClick = btnClick;
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews{
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    returnBtn.frame = CGRectMake(sw-35, 5, 25, 15);
    [returnBtn setTitle:@"❌" forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:returnBtn];
    
    NSArray *titles = @[@"撤单改单",@"成交明细",@"成交合并",@"股票往来",@"新股申购",@"银证转账"];
    NSArray *imgNames =@[@"hk.png",@"China.png",@"American.png",@"1.jpg",@"hk.png",@"hk.png"];
    NSMutableArray *imgs = @[].mutableCopy;
    for (int i=0; i<imgNames.count; i++) {
        UIImage *img = [UIImage imageNamed:imgNames[i]];
        if (img) {
            [imgs addObject:img];
        }
    }
    
    
    for (int i=0; i<titles.count; i++) {
       myBtn *btn = [[myBtn alloc]initWithFrame:CGRectMake(50, 20+30*i, 200, 40) img:imgs[i] title:titles[i] touchEvent:^(myBtn *btn) {
           [self.superview removeFromSuperview];
           if (_btnClick) {
               _btnClick(btn);
           }
           
       } andbtnType:BTNTYPEOTHER];
        btn.tag = 300+i;
        btn.lab.textColor =  [UIColor grayColor];
        [self addSubview:btn];
    }
    
}

-(void)remove{
    [self.superview removeFromSuperview];
}

@end
