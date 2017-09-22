//
//  ZQsSelectMenu.h
//  HKTest
//
//  Created by QianLong on 2017/9/20.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQSelectView.h"
#import "ZQModel.h"

@class ZQModel;

@interface ZQsSelectMenu : UIView
-(void)addZqModels:(NSArray<ZQModel*>*)zqModels  selectEvent:(selectBlock)selectHander  addNewZQClick:(addNewZQClick)addNewZQHander;

@end
