//
//  JYSelectMedu.h
//  HKTest
//
//  Created by QianLong on 2017/9/20.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myBtn.h"

typedef void(^btnTouch)(myBtn *btn);

@interface JYSelectMedu : UIView

-(instancetype)initWithFrame:(CGRect)frame  btnClick:(btnTouch)btnClick;

@end
