//
//  ZQSelectView.h
//  HKTest
//
//  Created by QianLong on 2017/9/20.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQModel.h"


typedef void(^selectBlock)(ZQModel *model);
typedef void(^addNewZQClick)(void);
@interface ZQSelectView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *ZQiconView;
@property (weak, nonatomic) IBOutlet UILabel *ZQNameLable;
@property (weak, nonatomic) IBOutlet UILabel *ZQAcountLable;
@property (weak, nonatomic) IBOutlet UIView *botomLine;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
//
@property(nonatomic,strong) addNewZQClick addNewZQClick;

+(instancetype)selectView;


-(void)setZqModel:(ZQModel *)zqModel whithSelectEvent:(selectBlock)selectEvent;


@end
