//
//  MyExtendView.h
//  initVC
//
//  Created by QianLong on 2017/9/5.
//  Copyright © 2017年 lrw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCellModle.h"
#import "JRDDealdDetailView.h"




@class myBtn;
@interface MyExtendView : UIView
//
@property(nonatomic,strong) NSIndexPath* path;
//
@property(nonatomic,strong) myCellModle *model;
@property(nonatomic,assign)NSInteger extenViewType; //1. 持仓 2.今日订单

//
@property(nonatomic,strong) void(^TouchBlock)(myBtn*btn,myCellModle*model,NSIndexPath*path);
@property(nonatomic,strong)NSArray<JRDDModel *>* jrddModels;

@property(nonatomic,strong)myBtn *hqUpDownBtn;

@end
