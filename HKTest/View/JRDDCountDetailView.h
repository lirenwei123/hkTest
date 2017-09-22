//
//  JRDDCountDetailView.h
//  HKTest
//
//  Created by QianLong on 2017/9/21.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^tapClick)(void);

@interface JRDDCountDetailView : UIView

@property(nonatomic,strong) tapClick click1,click2,click3,click4;
/* 全部订单     */
@property (weak, nonatomic) IBOutlet UIButton *allDD;
/* 已成交     */
@property (weak, nonatomic) IBOutlet UIButton *YCJ;
/* 待成交     */
@property (weak, nonatomic) IBOutlet UIButton *DCJ;
/* 已撤单     */
@property (weak, nonatomic) IBOutlet UIButton *YCD;

+(instancetype)creatView;

-(void)setALLcount:(NSInteger )count1 ALLclick:(tapClick)allclick
       YCJcount:(NSInteger )count2  YCJclick:(tapClick)YCJclick
       DCJcount:(NSInteger )count3  DCJclick:(tapClick)DCJclick
       YCDcount:(NSInteger )count4  YCDclick:(tapClick)YCDclick  ;
@end
