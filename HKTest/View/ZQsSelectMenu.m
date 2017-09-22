//
//  ZQsSelectMenu.m
//  HKTest
//
//  Created by QianLong on 2017/9/20.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "ZQsSelectMenu.h"


@interface ZQsSelectMenu ()
//
@property(nonatomic,strong) NSArray <ZQModel*>*Models;
//
@property(nonatomic,strong) selectBlock selectHander;
//
@property(nonatomic,strong) addNewZQClick addNewZQHander;
@end
@implementation ZQsSelectMenu

-(void)addZqModels:(NSArray<ZQModel*>*)zqModels  selectEvent:(selectBlock)selectHander  addNewZQClick:(addNewZQClick)addNewZQHander{
        _Models = zqModels;
        _selectHander = selectHander;
        _addNewZQHander  = addNewZQHander;
    [self addZQView];
}

-(void)addZQView{
    if (_Models) {
        for (int i=0; i<_Models.count; i++) {
            ZQModel *model = _Models[i];
            ZQSelectView *zqV = [ZQSelectView selectView];
            [zqV setZqModel:model whithSelectEvent:^(ZQModel *model) {
                //这里是选择券商和账号后 代码
                if (_selectHander) {
                    _selectHander(model);
                     [self.superview removeFromSuperview];
                }
            }];
            zqV.frame = CGRectMake(0, i*80, 300, 80);
            zqV.markBtn.hidden = i==0?NO:YES;
            [self addSubview:zqV];
        }
    }
    [self addNewZQView];
}
-(void)addNewZQView{
    ZQSelectView * new = [ZQSelectView selectView];
    new.botomLine.hidden = YES;
    new.ZQiconView.image = [UIImage imageNamed:@"1.jpg"];
    new.ZQNameLable.text = @"添加新账号";
    new.ZQAcountLable.text = @"";
    new.frame = CGRectMake(0, 80*_Models.count, 300, 80);
    new.addNewZQClick = ^{
        //添加新账号的代码
        if (_addNewZQHander) {
            _addNewZQHander();
             [self.superview removeFromSuperview];
        }
    };
    [self addSubview:new];
    
}



@end
