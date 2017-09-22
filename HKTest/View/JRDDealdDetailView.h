//
//  JRDDealdDetailView.h
//  HKTest
//
//  Created by QianLong on 2017/9/22.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//




/*今日订单成交明细     */


#import <UIKit/UIKit.h>
#import "JRDDModel.h"

@interface JRDDealdDetailView : UIView

+(instancetype)dealdDetailView;
-(void)loadDataQWithModel:(JRDDModel *)data;
@end
