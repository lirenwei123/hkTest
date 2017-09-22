//
//  ZQSelectView.m
//  HKTest
//
//  Created by QianLong on 2017/9/20.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "ZQSelectView.h"


@interface ZQSelectView ()
//
@property(nonatomic,strong) ZQModel  *zqModel;
//
@property(nonatomic,strong) selectBlock selcetClick;
@end
@implementation ZQSelectView


+(instancetype)selectView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}


-(void)setZqModel:(ZQModel *)zqModel whithSelectEvent:(selectBlock)selectEvent{
    _selcetClick = selectEvent;
    _zqModel = zqModel;
    _ZQiconView.image = _zqModel.ZQIcon;
    _ZQNameLable.text = _zqModel.ZQName;
    _ZQAcountLable.text = [NSString stringWithFormat:@"账号: %@",_zqModel.ZQAcount];
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _markBtn.hidden = NO;
    if (_selcetClick) {
        _selcetClick(_zqModel);
    }
    if (_addNewZQClick) {
        _addNewZQClick();
    }
}
@end
