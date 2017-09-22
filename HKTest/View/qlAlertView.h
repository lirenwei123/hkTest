//
//  qlAlertView.h
//  HKTest
//
//  Created by QianLong on 2017/9/18.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class qlAlertView;
typedef void(^btnBlcok)(qlAlertView* alertView, UIButton *  sender);

@interface qlAlertView : UIView

-(instancetype)initWithView:(UIView *)view andDefultButtonBlock:(btnBlcok)DefultButtonBlock DefultButtontitle:(NSString *)DefultButtontitle andOtherButtonBlock:(btnBlcok)OtherButtonBlock OtherButtontitle:(NSString *)OtherButtontitle;

@end
