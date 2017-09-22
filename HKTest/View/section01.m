//
//  section01.m
//  HKTest
//
//  Created by QianLong on 2017/9/14.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "section01.h"
#import "ZiChanView.h"

@interface section01 ()
//
@property(nonatomic,strong) void (^myZiChanTouchBlock)();

//
@property(nonatomic,strong) NSArray *icons;
//
@property(nonatomic,strong) NSArray *titles;
//
@property(nonatomic,strong) NSArray *datas;
//
@property(nonatomic,assign)NSInteger dispalyDataCount;
@end
@implementation section01



-(instancetype)initWithFrame:(CGRect)frame Icons:(NSArray<UIImage *> *)icons titles:(NSArray<NSAttributedString *> *)titles andDatas:(NSArray<NSArray *> *)datas dispalyDataCount:(NSInteger)dispalyDataCount andUpDownBtnClick:(void(^)())myZJTouch{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor=  [UIColor lightGrayColor];
        _myZiChanTouchBlock = myZJTouch;
        _icons = icons;
        _titles = titles;
        _datas = datas;
        _dispalyDataCount = dispalyDataCount;
        [self reloadDatasWithdisPlayDataCount:_dispalyDataCount];
    }
    return self;
}


-(void)reloadDatasWithdisPlayDataCount:(NSInteger)count{
if (_datas.count == 0) {
        return;
    }
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    CGFloat w= 0;
    if (_datas.count==1) {
        w = self.frame.size.width;
    }else if (_datas.count == 2){
        w = self.frame.size.width*0.5;
    }else{
        w = self.frame.size.width*0.5-50;
    }
    
    UIScrollView *bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height-20)];
    bgScrollView.bounces = NO;
    bgScrollView.backgroundColor = [UIColor whiteColor];
    bgScrollView.contentSize = CGSizeMake(w*_datas.count, 0);
    bgScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:bgScrollView];
    
    for (int i=0; i<_datas.count; i++) {
         ZiChanView *zcV = [[ZiChanView alloc]initWithFrame:CGRectMake(i*w, 0, w, self.frame.size.height-20) currencyImage:_icons[i] title:_titles[i] andData:_datas[i] displayDataCount:(int)count upDownBlock:^(UIButton *btn) {
             if (_myZiChanTouchBlock) {
                 _myZiChanTouchBlock();
             }
         }];
        if (_datas.count == 1 || i == _datas.count-1) {
            zcV.seperateLine.hidden = YES;
        }
        [bgScrollView addSubview:zcV];
    }
    
}
@end
